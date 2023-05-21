import Foundation

/// Response from the `getSpeciesList` endpoint
struct SpeciesResponse: Mappable {
    let count: Int
    let results: [Species]
}

/// Species object returned as part of the `SpeciesResponse` object from the `getSpeciesList` endpoint
struct Species: Mappable {
    
    let name: String
    let url: URL
    var species_id: String? {
        if let lastPathComponent = url.absoluteString.split(separator: "/").last {
            return String(lastPathComponent)
        }
        return nil
    }
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
    
    func imageURL() -> String? {
        guard let id = species_id else {
            return nil
        }
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
