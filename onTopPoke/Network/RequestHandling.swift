import Foundation

enum NetworkCoreErrorType: Int, Swift.Error {
    case notFound
    case businessError
    case forbidden
    case serviceDown
    case cancelled
    case noConnection
    case unknown
    case noContent
    case `internal`
}

struct NetworkCoreResponse {
    let statusCode: Int
    let data: Data
    let headers: [AnyHashable: Any]
    let handler: NetworkCoreHandler
    
    init(statusCode: Int, data: Data?, headers: [AnyHashable : Any], handler: NetworkCoreHandler) {
        self.statusCode = statusCode
        self.data = data ?? Data()
        self.headers = headers
        self.handler = handler
    }
}

extension NetworkCoreResponse {
    static var internalError: NetworkCoreResponse {
        let error = NetworkCoreErrorType.internal
        return NetworkCoreResponse(statusCode: error.rawValue, data: Data(), headers: [:], handler: .error(error))
    }
    
    static var noConnection: NetworkCoreResponse {
        let error = NetworkCoreErrorType.noConnection
        return NetworkCoreResponse(statusCode: error.rawValue, data: Data(), headers: [:], handler: .error(error))
    }
    
    static func errorWithCode(_ code: Int) -> NetworkCoreResponse {
        let handler = NetworkCoreHandler(statusCode: code)
        return NetworkCoreResponse(statusCode: code, data: Data(), headers: [:], handler: handler)
    }
}

enum NetworkCoreHandler {
    case success
    
    case error(NetworkCoreErrorType)
    
    init(statusCode: Int) {
        switch NetworkCoreStatusCode(rawValue: statusCode) {
        case .noContent, .unknown:
            self = .error(.unknown)
        case .noConnection:
            self = .error(.noConnection)
        case .statusOK:
            self = .success
        case .badRequest:
            self = .error(.businessError)
        case .notFound:
            self = .error(.notFound)
        case .internalServerError:
            self = .error(.unknown)
        default:
            self = .error(.unknown)
        }
    }
}

enum NetworkCoreStatusCode: Int {
    case noConnection = 0
    case unknown = -998
    case statusOK = 200
    case noContent = 204
    case badRequest = 400
    case notFound = 404
    case internalServerError = 500
    case created = 201
}

/// Protocol for the `RequestHandler` you will build.
///
/// It's fine to change the signature of the request method, for example by adding a `where` clause to constrain the generic `T`.
/// More elaborate changes are also required, but try to make sure the `RequestHandler` is generalized enough to work on potential new `APIRoute`s as well.
protocol RequestHandling {
    func request<T>(route: APIRoute, completion: @escaping (Result<T, Error>) -> Void) throws
    
    associatedtype DataType: Codable
    
    var network: NetworkCore { get }
    
    var endpoint: APIRoute { get }
    
    func request(completion: @escaping (Result<DataType, NetworkCoreErrorType>) -> Void)
}

final class NetworkCore {
    
    func createSession() -> URLSession {
        return URLSession(configuration: .default)
    }
    
    func request(for endpoint: APIRoute) async throws -> NetworkCoreResponse {
        do {
            let (data, response) = try await URLSession.shared.data(for: endpoint.asRequest())
            return handleResponse(endpoint, data, response, nil)
        } catch {
            return handleResponse(endpoint, nil, nil, error)
        }
    }
    
    func handleResponse(_ endpoint: APIRoute, _ data: Data?, _ response: URLResponse?, _ error: Error?) -> NetworkCoreResponse {
        guard let httpResponse = response as? HTTPURLResponse else {
            if let error = error {
                let errorResponse = NetworkCoreResponse.errorWithCode(error._code)
                return errorResponse
            } else {
                let errorResponse = NetworkCoreResponse.noConnection
                return errorResponse
            }
        }
        let response = NetworkCoreResponse(statusCode: httpResponse.statusCode,
                                           data: data ?? Data(),
                                           headers: httpResponse.allHeaderFields,
                                           handler: NetworkCoreHandler(statusCode: httpResponse.statusCode))
        return response
    }
}
