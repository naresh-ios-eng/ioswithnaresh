//
//  UserStore.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Foundation

final class UserStore {
    
    private init() { 
        fatalError("This class must not be initialised")
    }
    
    static var accessToken: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserStoreKey.accessToken.key)
        }
        get {
            UserDefaults.standard.string(forKey: UserStoreKey.accessToken.key)
        }
    }
    
    static var refreshToken: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserStoreKey.accessToken.key)
        }
        get {
            UserDefaults.standard.string(forKey: UserStoreKey.accessToken.key)
        }
    }
}
