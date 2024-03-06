//
//  Coin.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 08.02.24.
//

import Foundation

struct Coin: Codable, Identifiable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let currentPrice: Double
    let marketCapRank: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}
