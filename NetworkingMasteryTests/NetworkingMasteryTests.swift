//
//  NetworkingMasteryTests.swift
//  NetworkingMasteryTests
//
//  Created by Baris Karalar on 22.02.24.
//

import XCTest
@testable import NetworkingMasterySwiftUI

final class NetworkingMasteryTests: XCTestCase {
    
    func test_DecodeCoinsIntoArray_marketCapDesc() throws {
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockCoinData_marketCapDesc)
            XCTAssertTrue(coins.count > 0) // ensures that coins array has coins
            XCTAssertFalse(coins.isEmpty) // ensures that coins array has coins
            XCTAssertEqual(coins.count, 20) // ensures that all coins were decoded
            
            XCTAssertEqual(coins, coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })) // ensures sorting order
            
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    override func setUpWithError() throws {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDownWithError() throws {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    //
    //    func testExample() throws {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //        // Any test you write for XCTest can be annotated as throws and async.
    //        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    //        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
