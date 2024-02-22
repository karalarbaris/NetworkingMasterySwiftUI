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
    
    init(coin: Coin,service: CoinServiceProtocol) {
        self.coin = coin
        self.vm = CoinDetailsViewModel(service: service, coinId: coin.id)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = vm.coinDetails {
                Text(details.name)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                
                Text(details.symbol)
                    .font(.footnote)
                
                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical)
            }
        }
        .task {
            await vm.fetchCoinDetails()
        }
        .padding()
        
    }
}

//#Preview {
//    CoinDetailsView()
//}
