//
//  CoinsViewModelTests.swift
//  NetworkingMasteryTests
//
//  Created by Baris Karalar on 05.03.24.
//

import XCTest
@testable import NetworkingMasterySwiftUI

class CoinsViewModelTests: XCTestCase {
    
    func testInit() { // This verifies that dependency injection works
        let service = MockCoinService()
        let vm = CoinsViewModel(service: service)
        
        XCTAssertNotNil(vm, "The view model should't be nil")
    }
    
    func testSuccessfulCoinsFetch() async {
        let service = MockCoinService()
        let vm = CoinsViewModel(service: service)
        
        await vm.fetchCoins()
        XCTAssertTrue(vm.coins.count > 0)
        XCTAssertEqual(vm.coins.count, 20) // ensures that all coins were decoded
        XCTAssertEqual(vm.coins, vm.coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })) // ensures sorting order
    }
    
    func testCoinFetchWithInvalidJSON() async {
        let service = MockCoinService()
        service.mockData = mockCoins_invalidJSON
        
        let vm = CoinsViewModel(service: service)
        
        await vm.fetchCoins()
        
        XCTAssertTrue(vm.coins.isEmpty)
        XCTAssertNotNil(vm.errorMessage)
    }
    
    func testThrowsInvalidDataError() async {
        let service = MockCoinService()
        service.mockError = CoinAPIError.invalidData
        
        let vm = CoinsViewModel(service: service)
        
        await vm.fetchCoins()
        
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertEqual(vm.errorMessage, CoinAPIError.invalidData.customDescription)
        
    }
    
    func testThrowsStatusCode() async {
        let service = MockCoinService()
        service.mockError = CoinAPIError.invalidStatusCode(statusCode: 404)
        
        let vm = CoinsViewModel(service: service)
        
        await vm.fetchCoins()
        
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertEqual(vm.errorMessage, CoinAPIError.invalidStatusCode(statusCode: 404).customDescription)
        
    }
}
