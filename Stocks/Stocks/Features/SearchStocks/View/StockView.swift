//
//  Stock.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import SwiftUI

struct StockView: View {
    
    @ObservedObject var viewModel: StockViewModel
   
    var body: some View {
        VStack {
            List($viewModel.stocks) { $stock in
                SearchItemView(stockModel: $stock)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .searchable(text: $viewModel.searchText, prompt: Text("Stock symbol"))
        .navigationTitle("Search Stocks")
    }
}

#Preview {
    StockView(viewModel: StockViewModel(serviceProvider: SearchStockServiceProvider()))
}
