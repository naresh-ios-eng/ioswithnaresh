//
//  SeachStockRoute.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Foundation

enum SeachStockRoute: Routable {
    
    case search(String)
    case getEquityDetail(String)
    
    var method: MethodType {
        switch self {
        case .search:
            .get
        case .getEquityDetail:
            .get
        }
    }
    
    var endPoint: String {
        switch self {
        case .search:
            "/api/search/autocomplete"
        case .getEquityDetail:
            "api/quote-equity"
        }
    }
    
    var additionalHeaders: [String : String]? {
        switch self {
        case .search:
            nil
        case .getEquityDetail:
            nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search:
            nil
        case .getEquityDetail:
            nil
        }
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .search(let text):
            ["q": text]
        case .getEquityDetail(let symbol):
            ["symbol": symbol]
        }
    }
}
