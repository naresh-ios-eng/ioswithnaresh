//
//  StockViewModel.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import Combine
import SwiftUI

final class StockViewModel: ObservableObject {
    
    @Published var stocks: [EquityModel] = []
    var watchList: [String] = []

    @Published var searchText: String = ""
    
    private var disposeBag = Set<AnyCancellable>()

    private var serviceProvider: SearchStockServiceProvidable
    
    init(serviceProvider: SearchStockServiceProvidable) {
        self.serviceProvider = serviceProvider
        self.addSearchObserver()
    }
    
    deinit {
        print(#function, " \t", String(describing: self))
    }
    
    /// This will add an observer on the **searchText** property, so that when the value got changed the we can perform the web search
    private func addSearchObserver() {
        $searchText.debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] in
                self?.search(text: $0)
            }
            .store(in: &disposeBag)
        
        /// Checking the updated on the stocks
        $stocks.sink { [weak self] models in
            let watchList = models.filter { $0.watchList }
                .map { $0.symbol }
            self?.watchList.append(contentsOf: watchList)
        }
        .store(in: &disposeBag)
    }
    
    private func search(text: String) {
        guard !text.isEmpty else {
            return
        }
        
        serviceProvider.searchStock(text: text)
            .sink { error in
                print("Completion with error - ", error)
            } receiveValue: { [weak self] resultModel in
                self?.stocks = (resultModel.equities ?? []) + (resultModel.mutualFunds ?? [])
            }
            .store(in: &disposeBag)
        }
}
