//import Foundation
//
//struct FakeRequestError: Error {}
//
///// This is RequestHandling implementation returns a hardcoded list of Species.
/////
///// This is to be replaced by a proper implementation that actually makes the network call given the APIRoute, parses the response, and returns the resulting object.
//class FakeRequestHandler: RequestHandling {
//    func request<T>(route: APIRoute, completion: @escaping (Result<T, Error>) -> Void) throws {
//        switch route {
//        case .getSpeciesList(let limit, _):
//            
//            Task {
//                do {
//                    let example = try await generateExampleSpecies(count: limit) as! T
//                    completion(.success(example))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        default:
//            completion(.failure(FakeRequestError()))
//        }
//    }
//    
//    private func generateExampleSpecies(count: Int) async throws -> SpeciesResponse {
//        let species = (0..<count).map { Species(name: "Pokémon \($0)", url: URL(string: "https://www.catawiki.com")!) }
//        
//        return SpeciesResponse(count: count, results: species)
//    }
//}
//
//private extension SpeciesResponse {
//    static func example(count: Int) -> SpeciesResponse {
//        let species = (0..<count).map { Species(name: "Pokémon \($0)", url: URL(string: "https://www.catawiki.com")!) }
//        
//        return SpeciesResponse(count: count, results: species)
//    }
//}
