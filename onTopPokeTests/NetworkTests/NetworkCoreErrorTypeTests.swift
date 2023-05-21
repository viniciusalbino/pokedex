//
//  NetworkCoreErrorTypeTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation
import XCTest
@testable import onTopPoke

class NetworkCoreErrorTypeTests: XCTestCase {
    func testRawValues() {
        XCTAssertEqual(NetworkCoreErrorType.notFound.rawValue, 0)
        XCTAssertEqual(NetworkCoreErrorType.businessError.rawValue, 1)
        XCTAssertEqual(NetworkCoreErrorType.forbidden.rawValue, 2)
        XCTAssertEqual(NetworkCoreErrorType.serviceDown.rawValue, 3)
        XCTAssertEqual(NetworkCoreErrorType.cancelled.rawValue, 4)
        XCTAssertEqual(NetworkCoreErrorType.noConnection.rawValue, 5)
        XCTAssertEqual(NetworkCoreErrorType.unknown.rawValue, 6)
        XCTAssertEqual(NetworkCoreErrorType.noContent.rawValue, 7)
        XCTAssertEqual(NetworkCoreErrorType.internal.rawValue, 8)
    }
    
    func testInitWithRawValue() {
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 0), .notFound)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 1), .businessError)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 2), .forbidden)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 3), .serviceDown)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 4), .cancelled)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 5), .noConnection)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 6), .unknown)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 7), .noContent)
        XCTAssertEqual(NetworkCoreErrorType(rawValue: 8), .internal)
        
        XCTAssertNil(NetworkCoreErrorType(rawValue: 9)) // Invalid raw value
    }
}
