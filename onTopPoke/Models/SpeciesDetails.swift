import Foundation

/// Species object returned as part of the `getSpeciesDetails` endpoint
struct SpeciesDetails: Mappable {
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
        case name
    }
    
    let name: String
    let evolutionChain: EvolutionChain
}

/// EvolutionChain model returned as part of the SpeciesDetails from the `getSpecies` endpoint
struct EvolutionChain: Mappable {
    let url: URL
}
