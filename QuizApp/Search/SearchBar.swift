import SwiftUI

struct SearchBar: View {

    @Binding var searchText: String

    @FocusState private var searchIsFocused: Bool

    var body: some View {
        HStack(alignment: .center) {
            TextField("Type here", text: $searchText)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(height: 40)
                .foregroundColor(.white)
                .background(Color.white.opacity(0.3))
                .cornerRadius(15)
                .focused($searchIsFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.white, lineWidth: searchIsFocused ? 1 : 0)
                )

            Button(action: {
                searchIsFocused = false
            }, label: {
                Text("Search")
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(.white)
            })
        }
    }

}
