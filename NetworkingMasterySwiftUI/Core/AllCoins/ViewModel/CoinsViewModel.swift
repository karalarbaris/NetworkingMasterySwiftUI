//
//  CoinsViewModel.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 05.02.24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage: String?
    
    private let service = CoinDataService()
    
    init() {
        fetchPrice(coin: "bitcoin")
//        fetchPrice(coin: "litecoin")
    }
    
    func fetchPrice(coin: String) {
        service.fetchPrice(coin: coin) { price in
            print("DEBUG: Price from service is \(price)")
            
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "\(price)"
            }
        }

    }
    
}
