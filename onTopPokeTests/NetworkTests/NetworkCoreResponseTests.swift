//
//  NetworkCoreResponseTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation

import XCTest
@testable import onTopPoke // Import your app module

class NetworkCoreResponseTests: XCTestCase {
    
    func testInit() {
        let statusCode = 200
        let data = Data()
        let headers: [AnyHashable: Any] = [:]
        let handler = NetworkCoreHandler.success
        
        let response = NetworkCoreResponse(statusCode: statusCode, data: data, headers: headers, handler: handler)
        
        XCTAssertEqual(response.statusCode, statusCode)
        XCTAssertEqual(response.data, data)
        XCTAssertNotNil(response.headers)
        XCTAssertEqual(response.handler, handler)
    }
    
    func testInitWithNilData() {
        let statusCode = 200
        let headers: [AnyHashable: Any] = [:]
        let handler = NetworkCoreHandler.success
        
        let response = NetworkCoreResponse(statusCode: statusCode, data: nil, headers: headers, handler: handler)
        
        XCTAssertEqual(response.statusCode, statusCode)
        XCTAssertEqual(response.data, Data())
        XCTAssertNotNil(response.headers)
        XCTAssertEqual(response.handler, handler)
    }
    
    func testInternalError() {
        let error = NetworkCoreErrorType.internal
        let expectedResponse = NetworkCoreResponse(statusCode: error.rawValue, data: Data(), headers: [:], handler: .error(error))
        let response = NetworkCoreResponse.internalError
        
        XCTAssertEqual(response.statusCode, expectedResponse.statusCode)
        XCTAssertEqual(response.data, expectedResponse.data)
        XCTAssertNotNil(response.headers)
        XCTAssertEqual(response.handler, expectedResponse.handler)
    }
    
    func testNoConnection() {
        let error = NetworkCoreErrorType.noConnection
        let expectedResponse = NetworkCoreResponse(statusCode: error.rawValue, data: Data(), headers: [:], handler: .error(error))
        let response = NetworkCoreResponse.noConnection
        
        XCTAssertEqual(response.statusCode, expectedResponse.statusCode)
        XCTAssertEqual(response.data, expectedResponse.data)
        XCTAssertNotNil(response.headers)
        XCTAssertEqual(response.handler, expectedResponse.handler)
    }
    
    func testErrorWithCode() {
        let statusCode = 404
        let handler = NetworkCoreHandler(statusCode: statusCode)
        let expectedResponse = NetworkCoreResponse(statusCode: statusCode, data: Data(), headers: [:], handler: handler)
        let response = NetworkCoreResponse.errorWithCode(statusCode)
        
        XCTAssertEqual(response.statusCode, expectedResponse.statusCode)
        XCTAssertEqual(response.data, expectedResponse.data)
        XCTAssertNotNil(response.headers)
        XCTAssertEqual(response.handler, expectedResponse.handler)
    }
}
