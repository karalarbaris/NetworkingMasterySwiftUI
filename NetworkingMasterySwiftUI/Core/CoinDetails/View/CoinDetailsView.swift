//
//  CoinDetailsView.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 13.02.24.
//

import SwiftUI

struct CoinDetailsView: View {
    
    let coin: Coin
    @ObservedObject var vm: CoinDetailsViewModel
    
    init(coin: Coin) {
        self.coin = coin
        self.vm = CoinDetailsViewModel(coinId: coin.id)
    }
    
    var body: some View {
        if let details = vm.coinDetails {
            VStack(alignment: .leading) {
                Text(details.name)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                
                Text(details.symbol)
                    .font(.footnote)
                
                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical)
//                Spacer()
            }
            .padding()
        }
    }
}

//#Preview {
//    CoinDetailsView()
//}
