import Foundation

enum RequestError: Error {

    case clientError
    case serverError
    case dataError
    case invalidURL
    case unknown

}
