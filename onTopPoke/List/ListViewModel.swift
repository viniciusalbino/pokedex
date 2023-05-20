//
//  ListViewModel.swift
//  onTopPoke
//
//  Created by Vinicius Albino on 20/05/23.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func didFetchSpecies(response: SpeciesResponse)
    func errorFetchingSpecies()
}

final class ListViewModel {
    private weak var delegate: ListViewModelDelegate?
    
    // MARK: - Properties
    private var currentPage: Int = 1
    private var totalPages: Int?
    private var currentOffset: Int = 0
    
    private var species: [Species] = []
    
    init(delegate: ListViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func loadContent() {
        // check if the info is nil, so do the first load
        guard let totalPages = self.totalPages else {
            self.loadpage(offset: currentOffset, limit: 20)
            return
        }
        // check if the currentPage is different than the total pages, otherwise is the last page
        guard currentPage != totalPages else {
            return
        }
        // check if the current page is less than the total pages, then load again
        if currentPage < totalPages {
            currentPage += 1
            loadpage(offset: currentOffset, limit: 20)
        }
    }
    
    private func loadpage(offset: Int, limit: Int) {
        let network = NetworkCore()
        let api: APIRoute = .getSpeciesList(limit: limit, offset: offset)
        Task {
            do {
                let response = try await network.request(for: api)
                if let data = response.data <--> SpeciesResponse.self {
                    currentOffset += data.results.count
                    totalPages = data.count / 20
                    species.append(contentsOf: data.results)
                    delegate?.didFetchSpecies(response: data)
                } else {
                    delegate?.errorFetchingSpecies()
                }
            }
            catch {
                print("TODO handle request handling failures failures")
            }
        }
    }
}

extension ListViewModel {
    func numberOfItensInSection() -> Int {
        return species.count
    }
    
    func itemForRowAt(_ row: Int) -> Species? {
        return species.object(index: row)
    }
}