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
    
    init() {
        fetchPrice(coin: "litecoin")
    }
    
    func fetchPrice(coin: String) {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        
        print("Fetching price..") // 1
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Did receive data \(String(describing: data))") // 3
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            guard let value = jsonObject[coin] as? [String: Double] else { return }
            guard let price = value["usd"] else { return }
            print("value: \(value)")
            
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "\(price)"
            }
            
        }.resume()
        
        print("Did reach end of function") // 2
        
        
    }
    
}
