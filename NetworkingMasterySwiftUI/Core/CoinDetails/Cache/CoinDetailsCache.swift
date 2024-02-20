//
//  CoinDetailsCache.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 20.02.24.
//

import Foundation

class CoinDetailsCache {
    
    static let shared = CoinDetailsCache()
    
    private let cache = NSCache<NSString, NSData>()
    
    private init() { }
    
    func set(_ coindetails: CoinDetails, forkey key: String) {
        guard let data = try? JSONEncoder().encode(coindetails) else { return }
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func get(forkey key: String) -> CoinDetails? {
        guard let data = cache.object(forKey: key as NSString) as? Data else { return nil }
        return try? JSONDecoder().decode(CoinDetails.self, from: data)
    }
    
    func set(coindetails: CoinDetails, key: String) {
        guard let data = try? JSONEncoder().encode(coindetails) else { return }
        cache.setObject(data as NSData, forKey: key as NSString)
    }

}
