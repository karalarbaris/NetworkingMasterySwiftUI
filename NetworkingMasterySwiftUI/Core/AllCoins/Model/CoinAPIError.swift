//
//  CoinAPIError.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 08.02.24.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Invalid data"
        case .jsonParsingFailure:
            return "Failed to parse JSON"
        case .requestFailed(let description):
            return "Request failed \(description)"
        case .invalidStatusCode(let statusCode):
            return "Invalid status code \(statusCode)"
        case .unknownError(let error):
            return "Unknown error occurred \(error.localizedDescription)"
        }
    }
}
