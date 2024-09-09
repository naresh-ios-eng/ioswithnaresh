//
//  UserStoreKey.swift
//  Stocks
//
//  Created by Naresh on 09/09/24.
//

import Foundation

protocol KeyProvidable {
    var key: String { get }
}

extension KeyProvidable {
    var key: String {
        String(describing: self) + "Key"
    }
}

enum UserStoreKey: KeyProvidable {
    case accessToken
    case refreshToken
}
