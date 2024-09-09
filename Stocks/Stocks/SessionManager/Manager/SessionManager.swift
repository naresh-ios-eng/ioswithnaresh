//
//  SessionManager.swift
//  ProductViewer
//
//  Created by Naresh on 08/09/2024.
//

import Foundation
import Combine

final public class SessionManager: NSObject {
    
    /// This is the singleton instance of this class
    public static var shared = SessionManager()
    /// The shared session
    private var session: URLSession
    /// Configuration
    private var configuration: URLSessionConfiguration
    /// After one minute the api will return timeout error
    private var timeout: TimeInterval = 60
    /// This enviroment must be fetched from the current scheme we are running. As of now we are hardcoding this.
    private var enviroment: Enviroment
    /// If internet is not there then any api call happen then on connectivity it will call the api.
    private let waitsForConnectivity: Bool = true
    /// variable for refreing the publisher.
    private var cancellable: Set<AnyCancellable> = []
    
    var refreshTokenPublisher: AnyPublisher<RefreshTokenModel, SessionError>?
    
    /// This will make this class as the singlton
    private override init() {
        /// ephemeral - a session configuration that uses no persistent storage for caches, cookies, or credentials.
        configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = timeout / 2
        configuration.timeoutIntervalForResource = timeout
        configuration.waitsForConnectivity = waitsForConnectivity
        session = URLSession.init(configuration: configuration)
        enviroment = .dev
    }
    
    
    /// This function will make the api call and returns the publisher.
    /// - Parameters:
    ///   - route: The api route. Route will provide complete api detail like url, method, body, parameters etc. The route will build the urlRequest also.
    ///   - responseType: The type of response the particular route will return.
    /// - Returns: It will return a publisher that can publish the response or error.
    public func dataTaskPublisher<T: Codable>(route: Routable, responseType: T.Type) -> AnyPublisher<T, SessionError> {
        /// Let make the url request first
        guard let urlRequest: URLRequest = try? route.urlRequest(enviroment: self.enviroment) else {
            /// As there is some issue while building the url request so let's return the fail publisher with session error invalidRequest
            return Fail(error: SessionError.invalidRequest)
                .eraseToAnyPublisher()
        }
        return session
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global()) /// I want this api to be fetched on global queue.
            .receive(on: RunLoop.main) /// I want the reponse on main queue.
            .tryMap() { [weak self] element -> Data in
                /// This function will map the data or throw some error, here we need map the api status code to our requirement, e.g if your server returned some specific code for dataNotAvailable, tokenExpired etc cases then you can map that to URLError here.
                guard let self = self else {
                    throw URLError(.badServerResponse)
                }
                /// handleData will map the status code to URLError or return some data for downstream
                return try self.handleData(element: element)
            }
            .decode(type: T.self, decoder: JSONDecoder()) /// Pasing the data recieved from tryMap upstead publisher to the required fromat with JSONDecoder() object
            .tryCatch({ [weak self] error in
                /// Here we will catch the error from upstream publishers like decode, tryMap etc.
                guard let self = self, let urlError = error as? URLError else {
                    /// Is error is not kind of URLError then simple throw an error.
                    throw error
                }
                /// This handle(urlError) function will handle the error. We will implement the logic like refresh token in this publisher, hence this handle(urlError) is doing that
                return try self.handle(urlError: urlError, route: route, responseType: responseType)
            })
            .mapError({ error in
                /// Mapping error from Error, URLError to SessionError is required because our **dataTaskPublisher** function return publisher of type **AnyPublisher<T, SessionError>**. So we need to map the error to session error.
                guard let urlError = error as? URLError else { return SessionError.internalServerError }
                return SessionError.error(code: urlError.code.rawValue, message: urlError.localizedDescription)
            })
            .retry(2) /// Retry mean if the api failed then it will make another 2 hits before sending any error to publisher. We can
            .eraseToAnyPublisher() /// This will convert the upstream publisher to **AnyPublisher<T, SessionError>** It's a kind of type casting.
    }
    
    /// This function will handle the url Error. Handling means throwing error or taking some action on particular error case. e.g if 401 comes in status code then we try to refresh the access token for all api's except refreshTokenApi
    /// - Parameters:
    ///- urlError: The URL error refrence
    ///- route: The route from which we get this error
    ///- responseType: The response type we want to send.
    /// - Returns: Publisher with response type or error
    private func handle<T: Codable>(urlError: URLError, route: Routable, responseType: T.Type) throws -> AnyPublisher<T, SessionError> {
        /// As we mapped the 401 to userAuthenticationRequired error, so handling that here. Let's refresh the accessToken with Refresh token api.
        if urlError.code == .userAuthenticationRequired || urlError.code == .userCancelledAuthentication {
            if route.endPoint != RefreshTokenRouter.refreshToken.endPoint {
                if refreshTokenPublisher == nil {
                    /// holding an instance of refresh token publisher, so that we shouldn't have the multiple
                    refreshTokenPublisher = RefreskTokenServiceProvider().refreshToken()
                }
                return refreshTokenPublisher!.flatMap { [unowned self] refreshTokenModel -> AnyPublisher<T, SessionError> in
                    /// Setting the new updated access token to store so that we can access.
                    UserStore.accessToken = refreshTokenModel.accessToken
                    /// Making the refresh token publisher as nil as it intended its pupose.
                    self.refreshTokenPublisher = nil
                    /// Finally making the same api call so that last api which thown 401 can be refetched again.
                    return self.dataTaskPublisher(route: route, responseType: responseType)
                }
                .eraseToAnyPublisher()
            } else {
                /// If the 401 returned by the refreshToken api itself then don't refresh the token again, it mean the refreshtoken is also expired. If we don that that means we are making the infinite loop here.
                throw urlError
            }
        } else {
            /// If the error code is other than 401 then return the error only
            throw urlError
        }
    }
    
    /// This function will map the error status code to the URLError and if there is not error then it will return the data
    /// - Parameter element: The output from the dataTaks upstream publisher
    /// - Returns: return data or throw error
    private func handleData(element: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = element.response as? HTTPURLResponse else {
            /// If response is not available throw an error.
            throw URLError(.badServerResponse)
        }
        /// If status code is 401 let's userAuthenticationRequired error, so that appropriate actions can be take.
        if response.statusCode == StatusCode.authoriztionFailed.rawValue {
            throw URLError(.userAuthenticationRequired)
        } else if response.statusCode == StatusCode.success.rawValue {
            /// Incase of status code 200 return the data.
            return element.data
        }
        /// Like wise you can add multiple error and success cases, for error case you have to throw an error and for success case you have to return some data.
        throw URLError(.unknown)
    }
}
