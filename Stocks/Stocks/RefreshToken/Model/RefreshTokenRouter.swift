//
//  RefreshTokenRouter.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Foundation

enum RefreshTokenRouter: Routable {
    
    case refreshToken
    
    var method: MethodType {
        return .post
    }
    
    var endPoint: String {
        return "refresh/token"
    }
    
    var additionalHeaders: [String : String]? {
        if let refreshToken = UserStore.refreshToken {
            return ["refreshToken": refreshToken]
        }
        return nil
    }
    
    var parameters: [String : Any]? {
        nil
    }
    
    var queryParams: [String : String]? {
        nil
    }
}
