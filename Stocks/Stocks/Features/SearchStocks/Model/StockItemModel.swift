//
//  StockItemModel.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Foundation

struct SearchResultModel: Codable {
    var equities: [EquityModel]?
    var mutualFunds: [EquityModel]?
    
    enum CodingKeys: String, CodingKey {
        case equities = "symbols"
        case mutualFunds = "mfsymbols"
    }
}

struct EquityModel: Codable, Identifiable {
    var id: UUID = UUID()
    var symbol: String
    var title: String
    var type: String
    var watchList: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case title = "symbol_info"
        case type = "result_sub_type"
    }
}



