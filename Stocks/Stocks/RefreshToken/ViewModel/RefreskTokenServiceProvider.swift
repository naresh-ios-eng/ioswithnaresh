//
//  RefreskTokenServiceProvider.swift
//  Stocks
//
//  Created by Naresh on08/09/2024.
//

import Combine

final class RefreskTokenServiceProvider: RefreshTokenServiceProvidable {
    
    func refreshToken() -> AnyPublisher<RefreshTokenModel, SessionError> {
        return SessionManager.shared.dataTaskPublisher(route: RefreshTokenRouter.refreshToken, responseType: RefreshTokenModel.self)
            .eraseToAnyPublisher()
        
        /*return Just(true)
         .setFailureType(to: SessionError.self)
         .eraseToAnyPublisher()*/
    }
}
