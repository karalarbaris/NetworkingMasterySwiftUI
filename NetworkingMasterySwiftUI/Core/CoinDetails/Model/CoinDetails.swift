//
//  CoinDetails.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 13.02.24.
//

import Foundation

struct CoinDetails: Codable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}

struct Description: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
