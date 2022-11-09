import Foundation

protocol ApiClientProtocol {

    func get(path: String) async throws

    func get<T: Decodable>(path: String, query: [URLQueryItem]?) async throws -> T

    func post(path: String, body: [String: String]?) async throws

    func post<T: Decodable>(path: String, body: [String: String]?) async throws -> T

    func patch(path: String, body: [String: String]?) async throws

}

class ApiClient: ApiClientProtocol {

    private var storage: SecureStorageProtocol

    init(storage: SecureStorageProtocol) {
        self.storage = storage
    }

    func get(path: String) async throws {
        try await execute(path: path, method: "GET", body: nil)
    }

    func get<T: Decodable>(path: String, query: [URLQueryItem]?) async throws -> T {
        return try await execute(path: path, method: "GET", body: nil, query: query)
    }

    func post(path: String, body: [String: String]?) async throws {
        try await execute(path: path, method: "POST", body: body)
    }

    func post<T: Decodable>(path: String, body: [String: String]?) async throws -> T {
        return try await execute(path: path, method: "POST", body: body, query: nil)
    }

    func patch(path: String, body: [String: String]?) async throws {
        try await execute(path: path, method: "PATCH", body: body)
    }

    func execute<T: Decodable>(
                    path: String,
                    method: String,
                    body: [String: String]?,
                    query: [URLQueryItem]?) async throws -> T {
        let URLRequest = try makeURLRequest(path: path, method: method, body: body, query: query)

        guard let (data, response) = try? await URLSession.shared.data(for: URLRequest) else {
            throw RequestError.serverError
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.dataError
        }

        if !(200...299).contains(httpResponse.statusCode) {
            switch httpResponse.statusCode {
            case 400...499:
                throw RequestError.clientError
            case 500...599:
                throw RequestError.serverError
            default:
                throw RequestError.unknown
            }
        } else {
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                throw RequestError.dataError
            }

            return value
        }
    }

    func execute(path: String, method: String, body: [String: String]?) async throws {
        let URLRequest = try makeURLRequest(path: path, method: method, body: body, query: nil)

        guard let (_, response) = try? await URLSession.shared.data(for: URLRequest) else {
            throw RequestError.serverError
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.dataError
        }

        if !(200...299).contains(httpResponse.statusCode) {
            switch httpResponse.statusCode {
            case 400...499:
                throw RequestError.clientError
            case 500...599:
                throw RequestError.serverError
            default:
                throw RequestError.unknown
            }
        }
    }

    func makeURLRequest(
                    path: String,
                    method: String,
                    body: [String: String]?,
                    query: [URLQueryItem]?) throws -> URLRequest {
        guard var URL = URL(string: path) else { throw RequestError.invalidURL }

        if let query = query {
            URL.append(queryItems: query)
        }

        var URLRequest = URLRequest(url: URL)
        URLRequest.httpMethod = method
        URLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let accessToken = storage.accessToken {
            URLRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        if let body = body {
            URLRequest.httpBody = try? JSONEncoder().encode(body)
        }

        return URLRequest
    }

}
