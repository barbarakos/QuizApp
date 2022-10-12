import Foundation
import Keychain

class SecureStorage {

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
