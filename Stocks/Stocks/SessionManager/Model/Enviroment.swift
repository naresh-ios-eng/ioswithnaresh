//
//  Enviroment.swift
//  ProductViewer
//
//  Created by Naresh on 08/09/2024.
//

import Foundation

@frozen public enum Enviroment {
    
    case dev
    /// Here we can define all our enviroments like **stage, qa, demo, prod etc**
    
    var baseUrl: String {
        switch self {
        case .dev:
            return "https://www.nseindia.com"
        }
    }
}
