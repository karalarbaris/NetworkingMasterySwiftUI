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
        Text(coin.name)
    }
}

//#Preview {
//    CoinDetailsView()
//}
