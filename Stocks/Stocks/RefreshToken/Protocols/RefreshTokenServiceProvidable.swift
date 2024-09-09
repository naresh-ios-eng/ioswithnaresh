//
//  RefreshTokenServiceProvidable.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Combine

protocol RefreshTokenServiceProvidable {
    /// This function will impose the confirming type to provide a publisher that can refresh the token or throw error
    /// - Returns: Publisher than can refresh the access token or throw error
    func refreshToken() -> AnyPublisher<RefreshTokenModel, SessionError>
}
