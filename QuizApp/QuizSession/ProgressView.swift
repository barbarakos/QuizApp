import SwiftUI

struct ProgressView: View {

    @Binding var progressColors: [Color]
    var numberOfQuestions: Int

    var body: some View {
        HStack(alignment: .center) {
            ForEach(0..<numberOfQuestions, id: \.self) { index in
                Capsule()
                    .fill(progressColors[index])
                    .frame(height: 5)
            }
        }
        .padding(.horizontal)
    }

}
