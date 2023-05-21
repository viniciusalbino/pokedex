//
//  Array+ExtensionsTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation
import XCTest

@testable import onTopPoke

class ArrayExtensionsTests: XCTestCase {
    
    let arrayObject = [1, 2, 3, 4, 5, 5]
    
    override func setUp() {
        super.setUp()
    }
    
    func testObject() {
        XCTAssertNotNil(arrayObject.object(index: 0))
        XCTAssertNotNil(arrayObject.object(index: 2))
        XCTAssertNil(arrayObject.object(index: 10))
    }
    
    func testIsNotEmpty() {
        XCTAssertTrue(!arrayObject.isEmpty)
        XCTAssertFalse(arrayObject.isEmpty)
    }
}
