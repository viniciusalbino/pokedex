import Foundation

/// EvolutionChain model returned from the `getEvolutionChain` endpoint
struct EvolutionChainDetails: Mappable {
    let chain: ChainLink
}

/// ChainLink model returned as part of the EvolutionChainDetails from the `getEvolutionChain` endpoint
struct ChainLink: Mappable {
    
    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
    
    let species: Species
    let evolvesTo: [ChainLink]?
}
