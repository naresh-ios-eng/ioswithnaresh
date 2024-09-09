//
//  RefreshTokenServiceProvidable.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Combine

protocol RefreshTokenServiceProvidable {
    
    func refreshToken() -> AnyPublisher<RefreshTokenModel, SessionError>
}
