//
//  CoinDataService.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 07.02.24.
//

import Foundation

protocol CoinServiceProtocol {
    func fetchCoins() async throws -> [Coin]
    func fetchCoinDetails(id: String) async throws -> CoinDetails?
}

class CoinDataService: CoinServiceProtocol, HTTPDataDownloader {
    
    var page = 0
    let fetchLimit = 25
    
    init() {
        print("DEBUG: Did init service")
    }
    //    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=25&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    
    func fetchCoins() async throws -> [Coin] {
        page += 1
        guard let endpoint = allCoinsURLString else {
            throw CoinAPIError.requestFailed(description: "Invalid endpoint")
        }
        return try await fetchData(as: [Coin].self, endpoint: endpoint)
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        if let cached = CoinDetailsCache.shared.get(forkey: id) {
            print("DEBUG: Got details from cache")
            return cached
        }
        guard let endpoint = coinDetailsURLString(id: id) else {
            throw CoinAPIError.requestFailed(description: "Invalid endpoint")
        }
        //        let detailsUrlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false"
        
        print("DEBUG: Got details from API")
        let coinDetails = try await fetchData(as: CoinDetails.self, endpoint: endpoint)
        CoinDetailsCache.shared.set(coinDetails, forkey: id)
        return coinDetails
    }
    
    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        return components
    }
    
    private var allCoinsURLString: String? {
        var components = baseURLComponents
        components.path += "markets"
        
        components.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "\(fetchLimit)"),
            .init(name: "page", value: "\(page)"),
            .init(name: "sparkline", value: "false"),
            .init(name: "price_change_percentage", value: "24h"),
            .init(name: "locale", value: "en")
        ]
        return components.url?.absoluteString
    }
    
    private func coinDetailsURLString(id: String) -> String? {
        var components = baseURLComponents
        components.path += id
        
        components.queryItems = [
            .init(name: "localization", value: "false")
        ]
        return components.url?.absoluteString
    }
    
}

// MARK: - Completion Handlers

extension CoinDataService {
    
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], CoinAPIError>) -> Void) {
        
        guard let url = URL(string: allCoinsURLString ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Bad HTTP response")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch {
                print("DEBUG: Failed to decode with error \(error)")
                completion(.failure(.jsonParsingFailure))
            }
            
        }.resume()
    }
    
    func fetchCoins(completion: @escaping([Coin]?, Error?) -> Void) {
        
        guard let url = URL(string: allCoinsURLString ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("DEBUG: Failed to decode coins")
                return
            }
            completion(coins, nil)
            
        }.resume()
    }
    
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("DEBUG: Failed with error: \(error.localizedDescription)")
                //                    self.errorMessage = error.localizedDescription
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                //                    self.errorMessage = "Bad HTTP response"
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                //                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            //                print("DEBUG: Response code is: \(httpResponse.statusCode)")
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value")
                return
            }
            guard let price = value["usd"] else { return }
            
            //                self.coin = coin.capitalized
            //                self.price = "\(price)"
            print("DEBUG: Price in service is \(price)")
            completion(price)
            
            
        }.resume()
        
    }
}
