//
//  DetailsViewModel.swift
//  onTopPoke
//
//  Created by Vinicius Albino on 20/05/23.
//

import Foundation

protocol DetailsViewModelDelegate: AnyObject {
    func finishedFetchingChain(evolutionSpecies: Species)
    func errorFetchingSpecies()
}

final class DetailsViewModel {
    private weak var delegate: DetailsViewModelDelegate?
    var currentSpecies: Species?
    
    init(delegate: DetailsViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func loadContent(specie: Species) {
        loadSpecies(specie: specie)
    }
    
    private func loadSpecies(specie: Species) {
        let network = NetworkCore()
        let api: APIRoute = .getSpecies(specie.url)
        Task {
            do {
                let response = try await network.request(for: api)
                if let data = response.data <--> SpeciesDetails.self {
                    loadEvolutionChain(speciesDetail: data)
                } else {
                    delegate?.errorFetchingSpecies()
                }
            }
        }
    }
    
    private func loadEvolutionChain(speciesDetail: SpeciesDetails) {
        let network = NetworkCore()
        let api: APIRoute = .getEvolutionChain(speciesDetail.evolutionChain.url)
        Task {
            do {
                let response = try await network.request(for: api)
                if let data = response.data <--> EvolutionChainDetails.self, let species = treatChain(chain: data) {
                    delegate?.finishedFetchingChain(evolutionSpecies: species)
                } else {
                    delegate?.errorFetchingSpecies()
                }
            }
        }
    }
    
    private func treatChain(chain: EvolutionChainDetails) -> Species? {
        var evolutionSpecies: Species?
        chain.chain.evolvesTo?.forEach({ specie in
            guard specie.species.species_id != currentSpecies?.species_id else {
                evolutionSpecies = specie.evolvesTo?.first?.species
                return
            }
            evolutionSpecies = specie.species
        })
        return evolutionSpecies
    }
}
