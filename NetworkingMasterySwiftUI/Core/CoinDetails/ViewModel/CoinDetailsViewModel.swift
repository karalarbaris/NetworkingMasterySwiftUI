//
//  CoinDetailsViewModel.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 13.02.24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service = CoinDataService()
    private let coinId: String
    
    @Published var coinDetails: CoinDetails?
    
    init(coinId: String) {
        self.coinId = coinId
        
//        Task {
//            await fetchCoinDetails()
//        }
    }
    
    @MainActor
    func fetchCoinDetails() async {
        
        print("DEBUG: Fetching coins")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("DEBUG: Task woke up")
        do {
            self.coinDetails = try await service.fetchCoinDetails(id: coinId)
            print("DEBUG: Details: \(String(describing: self.coinDetails)) ")
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
