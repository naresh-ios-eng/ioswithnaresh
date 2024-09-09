//
//  SeachStockProtocols.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Combine

protocol SearchStockServiceProvidable {
    func searchStock(text: String) -> AnyPublisher<SearchResultModel, SessionError>
}
