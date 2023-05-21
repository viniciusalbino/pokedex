//
//  ListViewModelTests.swift
//  onTopPokeTests
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation
import XCTest

@testable import onTopPoke

class ListViewModelTests: XCTestCase {
    
    class MockDelegate: ListViewModelDelegate {
        var didFetchSpeciesCalled = false
        var errorFetchingSpeciesCalled = false
        var speciesResponse: SpeciesResponse?
        
        func didFetchSpecies(response: SpeciesResponse) {
            didFetchSpeciesCalled = true
            speciesResponse = response
        }
        
        func errorFetchingSpecies() {
            errorFetchingSpeciesCalled = true
        }
    }
    
    func testLoadContent_FirstLoad() {
        let mockDelegate = MockDelegate()
        let viewModel = ListViewModel(delegate: mockDelegate)
        
        viewModel.loadContent()
        
        // Verify that the initial load is triggered
        XCTAssertFalse(mockDelegate.errorFetchingSpeciesCalled)
    }
    
    func testLoadContent_LoadAgain() {
        let mockDelegate = MockDelegate()
        let viewModel = ListViewModel(delegate: mockDelegate)
        viewModel.totalPages = 3
        viewModel.currentPage = 2
        
        viewModel.loadContent()
        
        // Verify that loading is triggered since there are more pages
        XCTAssertFalse(mockDelegate.errorFetchingSpeciesCalled)
    }
    
    func testLoadContent_LastPage() {
        let mockDelegate = MockDelegate()
        let viewModel = ListViewModel(delegate: mockDelegate)
        viewModel.totalPages = 3
        viewModel.currentPage = 3
        
        viewModel.loadContent()
        
        // Verify that loading is not triggered since it's the last page
        XCTAssertFalse(mockDelegate.didFetchSpeciesCalled)
        XCTAssertFalse(mockDelegate.errorFetchingSpeciesCalled)
    }
    
    func testNumberOfItemsInSection() {
        let mockDelegate = MockDelegate()
        let viewModel = ListViewModel(delegate: mockDelegate)
        
        viewModel.species = [Species(), Species(), Species()]
        
        XCTAssertEqual(viewModel.numberOfItensInSection(), viewModel.species.count)
    }
    
    func testItemForRowAt() {
        let mockDelegate = MockDelegate()
        let viewModel = ListViewModel(delegate: mockDelegate)
        let species = Species(name: "Pikachu", url: URL(string: "https://pokeapi.co/api/v2/pokemon/25")!)
        
        viewModel.species = [species, Species(), Species()]
        
        XCTAssertEqual(viewModel.itemForRowAt(0), species)
        XCTAssertNil(viewModel.itemForRowAt(3))
    }
}
