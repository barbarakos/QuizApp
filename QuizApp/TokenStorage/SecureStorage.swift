import Foundation
import Keychain

class SecureStorage {

    private let keychain = Keychain()

    var accessToken: String? {
        keychain.value(forKey: "accessToken") as? String
    }

    func save(accessToken: String) {
        _ = keychain.save(accessToken, forKey: "accessToken")
    }

    func deleteToken() {
        _ = keychain.remove(forKey: "accessToken")
    }

}
