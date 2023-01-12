import SwiftUI

extension View {

    func popup(isPresented: Binding<Bool>) -> some View {
        return modifier(NoInternetView(isPresented: isPresented))
    }

}
