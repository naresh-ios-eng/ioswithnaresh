//
//  SeachStockProtocols.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Combine

protocol SearchStockServiceProvidable {
    /// This fuction will provide the stock infomtion like the name, symbol etc.
    /// - Parameter text: The text that will match the stock symbol or stock name.
    /// - Returns: Publisher with SearchResultModel or SessionError based on the search result
    func searchStock(text: String) -> AnyPublisher<SearchResultModel, SessionError>
}
