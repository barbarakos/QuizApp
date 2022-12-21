import SwiftUI

struct ErrorView: View {

    @State var title: String
    @State var description: String

    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            Image("error")
                .scaledToFit()
                .tint(.white)

            Text(title)
                .font(.system(size: 22))
                .bold()
                .foregroundColor(.white)

            Text(description)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 40)
        .padding(.top, 100)
    }

}

struct ErrorView_Previews: PreviewProvider {

    static var previews: some View {
        ErrorView(title: "Error", description: "Description")
    }

}
