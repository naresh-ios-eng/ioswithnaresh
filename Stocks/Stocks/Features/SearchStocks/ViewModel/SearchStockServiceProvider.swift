//
//  SearchStockServiceProvider.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Combine

final class SearchStockServiceProvider: SearchStockServiceProvidable {
    
    func searchStock(text: String) -> AnyPublisher<SearchResultModel, SessionError> {
        let route = SeachStockRoute.search(text)
        return SessionManager.shared.dataTaskPublisher(route: route, responseType: SearchResultModel.self)
    }
}
