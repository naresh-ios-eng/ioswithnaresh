//
//  SearchItemView.swift
//  Stocks
//
//  Created by Naresh on 08/09/2024.
//

import SwiftUI
import SwiftData

struct SearchItemView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Binding var stockModel: EquityModel

    var body: some View {
        VStack(spacing: 8) {
            HStack(content: {
                Text(stockModel.title)
                    .font(AppFont.SFPro.bold(16).font)
                    .foregroundStyle(AppColor.black.color)
                Spacer()
                Button(action: {
                    stockModel.watchList.toggle()
                }, label: {
                    if stockModel.watchList {
                        Image(systemName: "heart.fill")
                            .tint(AppColor.red.color)
                    } else {
                        Image(systemName: "heart")
                            .tint(AppColor.gray.color)
                    }
                })
            })
            HStack(content: {
                Text(stockModel.symbol)
                    .foregroundStyle(AppColor.gray.color)
                    .font(AppFont.SFPro.regular(12).font)
                Spacer()
                Text(stockModel.type.uppercased())
                    .foregroundStyle(AppColor.gray.color)
                    .font(AppFont.SFPro.regular(12).font)
                    .padding(.leading, 16)
            })
            Divider()
                .foregroundColor(AppColor.lightGray.color)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
