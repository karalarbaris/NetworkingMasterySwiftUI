//
//  MockCoinService.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 22.02.24.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    func fetchCoins() async throws -> [Coin] {
        let coin = Coin(id: "etherium", symbol: "eth", name: "etherium", currentPrice: 22, marketCapRank: 3)
        let coin2 = Coin(id: "bitcoin", symbol: "btc", name: "bitcoin", currentPrice: 53, marketCapRank: 32)
        return [coin, coin2]
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let coinDetail = CoinDetails(id: "bitcoin", symbol: "btc", name: "bitcoin", description: Description(text: "bitcoin asdfasdf asdf fdsa asdf bitcoin bitcoin bitcoin"))
        return coinDetail
    }
    
    
}
