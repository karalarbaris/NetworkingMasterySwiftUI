//
//  MockCoinService.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 22.02.24.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    
    var mockData: Data?
    var mockError: CoinAPIError?
    
    func fetchCoins() async throws -> [Coin] {
        
        if let mockError {
            throw mockError
        }
        
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockData ?? mockCoinData_marketCapDesc)
            return coins
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
        
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let coinDetail = CoinDetails(id: "bitcoin", symbol: "btc", name: "bitcoin", description: Description(text: "bitcoin asdfasdf asdf fdsa asdf bitcoin bitcoin bitcoin"))
        return coinDetail
    }
    
    
}
