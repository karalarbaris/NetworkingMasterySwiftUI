//
//  CoinDetailsViewModel.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 13.02.24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service: CoinServiceProtocol
    private let coinId: String
    
    @Published var coinDetails: CoinDetails?
    
    init(service: CoinServiceProtocol, coinId: String) {
        self.service = service
        self.coinId = coinId
        
//        Task {
//            await fetchCoinDetails()
//        }
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            self.coinDetails = try await service.fetchCoinDetails(id: coinId)
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
