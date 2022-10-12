import Foundation

class CheckClient {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let checkPath = "api/v1/check"

    let storage = SecureStorage()

    func checkAccessToken() async throws {
        guard let URL = URL(string: "\(baseURL)\(checkPath)") else {
            throw RequestError.invalidURL
        }

        var URLrequest = URLRequest(url: URL)
        URLrequest.addValue("Bearer \(storage.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        URLrequest.httpMethod = "GET"

        try await executeURLRequest(URLrequest: URLrequest)
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
