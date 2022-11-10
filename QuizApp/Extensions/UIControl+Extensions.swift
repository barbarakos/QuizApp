import Combine
import UIKit

extension UITextField {

    var textDidChange: AnyPublisher<String, Never> {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }

    var textDidBeginEditing: AnyPublisher<UITextField, Never> {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidBeginEditingNotification, object: self)
            .map { $0.object as? UITextField }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    var textDidEndEditing: AnyPublisher<UITextField, Never> {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .map { $0.object as? UITextField }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    func notifyTextChanged() {
        NotificationCenter
            .default
            .post(name: UITextField.textDidChangeNotification, object: self)
    }

}
