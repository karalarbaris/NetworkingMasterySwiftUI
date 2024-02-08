//
//  CoinsViewModel.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 05.02.24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    
    private let service = CoinDataService()
    
    init() {
//        fetchPrice(coin: "bitcoin")
        fetchCoins()
    }
    
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins                
            }
        }
    }
    
}
