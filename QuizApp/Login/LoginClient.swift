import Foundation

class LoginClient {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let loginPath = "v1/login"

    func login(password: String, username: String) async throws -> LoginResponseModel {
        guard let URL = URL(string: "\(baseURL)\(loginPath)") else {
            throw RequestError.invalidURL
        }
        var URLrequest = URLRequest(url: URL)
        URLrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLrequest.httpMethod =  "POST"
        let reqBody = LoginRequestModel(password: password, username: username)
        let reqBodyJSON = try? JSONEncoder().encode(reqBody)
        URLrequest.httpBody = reqBodyJSON

        let response: LoginResponseModel = try await executeURLRequest(URLrequest: URLrequest)
        return response
    }

    func executeURLRequest(URLrequest: URLRequest) async throws -> LoginResponseModel {
        guard let (data, response) = try? await URLSession.shared.data(for: URLrequest) else {
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
            guard let value = try? JSONDecoder().decode(LoginResponseModel.self, from: data) else {
                throw RequestError.dataError
            }
            return value
        }

    }

}

struct LoginRequestModel: Encodable {

    let password: String
    let username: String

}

struct LoginResponseModel: Decodable {

    let accesToken: String

}

enum RequestError: Error {

    case clientError
    case serverError
    case dataError
    case invalidURL
    case unknown

}
