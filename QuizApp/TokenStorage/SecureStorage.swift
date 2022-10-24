import Foundation
import Keychain

protocol SecureStorageProtocol {

    var accessToken: String? { get }
    func save(accessToken: String)
    func deleteToken()

}

class SecureStorage: SecureStorageProtocol {

    private let keychain = Keychain()
    private let accessTokenKey = "accessToken"

    var accessToken: String? {
        keychain.value(forKey: accessTokenKey) as? String
    }

    func save(accessToken: String) {
        _ = keychain.save(accessToken, forKey: accessTokenKey)
    }

    func deleteToken() {
        _ = keychain.remove(forKey: accessTokenKey)
    }

}
