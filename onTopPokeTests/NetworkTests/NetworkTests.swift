//
//  NetworkTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation
import XCTest
@testable import onTopPoke

class NetworkCoreTests: XCTestCase {
    
    func testRequestSuccess() {
        let networkCore = NetworkCore()
        let endpoint = APIRoute.getSpeciesList(limit: 0, offset: 20)
        
        let expectation = XCTestExpectation(description: "Request completed successfully")
        
        Task {
            do {
                let response = try await networkCore.request(for: endpoint)
                
                // Assert the response is as expected
                XCTAssertEqual(response.statusCode, 200)
                // Additional assertions on data, headers, and handler
                XCTAssertNotNil(response.data)
                XCTAssertNotNil(response.headers)
                
                guard  let data = response.data <--> SpeciesResponse.self else {
                    XCTFail("Parse failed with error")
                    return
                }
                XCTAssertEqual(data.count, 1010)
                XCTAssertNotNil(data.results)
                
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testHandleResponseFailure() {
        let networkCore = NetworkCore()
        let endpoint = APIRoute.getSpeciesList(limit: 0, offset: 20)
        
        // Simulate a network error
        let error = NSError(domain: "TestError", code: 123, userInfo: nil)
        
        let networkCoreResponse = networkCore.handleResponse(endpoint, nil, nil, error)
        
        // Assert the networkCoreResponse is as expected
        XCTAssertEqual(networkCoreResponse.statusCode, 123)
        // Additional assertions on data, headers, and handler
    }
}
