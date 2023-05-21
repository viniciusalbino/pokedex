//
//  APIRouteTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation
import XCTest
@testable import onTopPoke

class APIRouteTests: XCTestCase {
    
    func testURLForGetSpeciesList() {
        let limit = 10
        let offset = 20
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon-species?limit=10&offset=20")
        let route = APIRoute.getSpeciesList(limit: limit, offset: offset)
        
        XCTAssertEqual(route.asRequest().url, expectedURL)
    }
    
    func testURLForGetSpecies() {
        let speciesURL = URL(string: "https://pokeapi.co/api/v2/pokemon-species/1?")
        let expectedURL = speciesURL
        let route = APIRoute.getSpecies(speciesURL!)
        
        XCTAssertEqual(route.asRequest().url, expectedURL)
    }
    
    func testURLForGetEvolutionChain() {
        let evolutionURL = URL(string: "https://pokeapi.co/api/v2/evolution-chain/1?")
        let expectedURL = evolutionURL
        let route = APIRoute.getEvolutionChain(evolutionURL!)
        
        XCTAssertEqual(route.asRequest().url, expectedURL)
    }
    
    func testURLRequestCreation() {
        let limit = 10
        let offset = 20
        let expectedURL = URL(string: "https://pokeapi.co/api/v2/pokemon-species?limit=10&offset=20")
        let expectedURLRequest = URLRequest(url: expectedURL!)
        let route = APIRoute.getSpeciesList(limit: limit, offset: offset)
        
        XCTAssertEqual(route.asRequest(), expectedURLRequest)
    }
}
