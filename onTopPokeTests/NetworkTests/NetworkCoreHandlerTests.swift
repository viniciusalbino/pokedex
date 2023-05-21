//
//  NetworkCoreHandlerTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation

import XCTest
@testable import onTopPoke

class NetworkCoreHandlerTests: XCTestCase {
    
    func testInitWithStatusCode() {
        XCTAssertEqual(NetworkCoreHandler(statusCode: 0), .error(.noConnection))
        XCTAssertEqual(NetworkCoreHandler(statusCode: -998), .error(.unknown))
        XCTAssertEqual(NetworkCoreHandler(statusCode: 200), .success)
        XCTAssertEqual(NetworkCoreHandler(statusCode: 204), .error(.unknown))
        XCTAssertEqual(NetworkCoreHandler(statusCode: 400), .error(.businessError))
        XCTAssertEqual(NetworkCoreHandler(statusCode: 404), .error(.notFound))
        XCTAssertEqual(NetworkCoreHandler(statusCode: 500), .error(.unknown))
        
        // Test an invalid status code
        XCTAssertEqual(NetworkCoreHandler(statusCode: 100), .error(.unknown))
    }
}
