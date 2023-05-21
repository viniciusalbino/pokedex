//
//  NetworkCoreStatusTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation

import XCTest
@testable import onTopPoke

class NetworkCoreStatusCodeTests: XCTestCase {
    func testRawValues() {
        XCTAssertEqual(NetworkCoreStatusCode.noConnection.rawValue, 0)
        XCTAssertEqual(NetworkCoreStatusCode.unknown.rawValue, -998)
        XCTAssertEqual(NetworkCoreStatusCode.statusOK.rawValue, 200)
        XCTAssertEqual(NetworkCoreStatusCode.noContent.rawValue, 204)
        XCTAssertEqual(NetworkCoreStatusCode.badRequest.rawValue, 400)
        XCTAssertEqual(NetworkCoreStatusCode.notFound.rawValue, 404)
        XCTAssertEqual(NetworkCoreStatusCode.internalServerError.rawValue, 500)
        XCTAssertEqual(NetworkCoreStatusCode.created.rawValue, 201)
    }
    
    func testInitWithRawValue() {
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: 0), .noConnection)
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: -998), .unknown)
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: 200), .statusOK)
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: 204), .noContent)
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: 400), .badRequest)
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: 404), .notFound)
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: 500), .internalServerError)
        XCTAssertEqual(NetworkCoreStatusCode(rawValue: 201), .created)
        
        XCTAssertNil(NetworkCoreStatusCode(rawValue: 100)) // Invalid raw value
        XCTAssertNil(NetworkCoreStatusCode(rawValue: -999)) // Invalid raw value
    }
}
