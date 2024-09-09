//
//  RefreskTokenServiceProvider.swift
//  Stocks
//
//  Created by Naresh on08/09/2024.
//

import Combine

final class RefreskTokenServiceProvider: RefreshTokenServiceProvidable {
    
    /// This function will  provide a publisher that can refresh the token or throw an error
    /// - Returns: Publisher than can refresh the access token or throw an error
    func refreshToken() -> AnyPublisher<RefreshTokenModel, SessionError> {
        return SessionManager.shared.dataTaskPublisher(route: RefreshTokenRouter.refreshToken, responseType: RefreshTokenModel.self)
            .eraseToAnyPublisher()
    }
}
