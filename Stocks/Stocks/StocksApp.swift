//
//  StocksApp.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import SwiftUI
import SwiftData

@main
struct StocksApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StockView(viewModel: StockViewModel(serviceProvider: SearchStockServiceProvider()))
            }
        }
    }
}
