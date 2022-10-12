import Foundation

protocol ApiClientProtocol {

    func executeURLRequest<T: Decodable>(URLrequest: URLRequest) async throws -> T
    func executeURLRequest(URLrequest: URLRequest) async throws

}

class ApiClient {

    func executeURLRequest<T: Decodable>(URLrequest: URLRequest) async throws -> T {
        guard let (data, response) = try? await URLSession.shared.data(for: URLrequest) else {
            throw RequestError.serverError
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.dataError
        }

        print(httpResponse.statusCode)
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

    func executeURLRequest(URLrequest: URLRequest) async throws {
        guard let (_, response) = try? await URLSession.shared.data(for: URLrequest) else {
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

}
