//
//  CoinsViewModel.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 05.02.24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    
    private let service = CoinDataService()
    
    init() {
//        fetchPrice(coin: "bitcoin")
        Task {
            try await fetchCoins()
        }
    }
    
    func fetchCoins() async throws {
            self.coins = try await service.fetchCoins()
    }
    
    func fetchCoinsWithCompletionHandler() {
        
        service.fetchCoinsWithResult { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    
//        service.fetchCoins { coins, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self.errorMessage = error.localizedDescription
//                    return
//                }
//                self.coins = coins ?? []
//            }
//        }
    }
    
}
