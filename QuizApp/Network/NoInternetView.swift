import SwiftUI

struct NoInternetView: View {

    var body: some View {
        HStack {
            Image(systemName: "wifi.slash")
            Text("We're offline. There is no internet connection.")
                .font(.system(size: 14))
        }
        .padding(20)
    }

}
