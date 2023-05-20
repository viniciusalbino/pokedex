import Foundation

/// Response from the `getSpeciesList` endpoint
struct SpeciesResponse {
    let count: Int
    let results: [Species]
}

/// Species object returned as part of the `SpeciesResponse` object from the `getSpeciesList` endpoint
struct Species {
    let name: String
    let url: URL
}
