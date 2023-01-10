import SwiftUI

extension View {

    func errorAlert(error: Binding<ValidationError?>, buttonTitle: String = "OK") -> some View {
        let errorAlert = ErrorAlert(error: error.wrappedValue)
        return alert(isPresented: .constant(errorAlert != nil), error: errorAlert) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { _ in
            Text(errorAlert!.recoverySuggestion ?? "")
        }
    }

}
