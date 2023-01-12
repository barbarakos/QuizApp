import SwiftUI

struct NoInternetView: ViewModifier {

    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
            .overlay(popup())
    }

    @ViewBuilder
    private func popup() -> some View {
            if isPresented {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "wifi.slash")

                        Text("We're offline. There is no internet connection.")
                            .font(.system(size: 14))
                    }
                    .padding(15)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Capsule())
                }
                .padding(.bottom, 15)
            }
    }

}
