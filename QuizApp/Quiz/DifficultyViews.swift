import SwiftUI

struct DifficultyViews: View {

    let type: DifficultyModel

    private let emptyFillColor = Color(white: 1).opacity(0.7)

    var body: some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 2)
                .rotation(Angle(degrees: 45))
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(.yellow)
            RoundedRectangle(cornerRadius: 2)
                .rotation(Angle(degrees: 45))
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(type != .easy ? .yellow : emptyFillColor)
            RoundedRectangle(cornerRadius: 2)
                .rotation(Angle(degrees: 45))
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(type == .hard ? .yellow : emptyFillColor)
        }
        .frame(width: 50, height: 10, alignment: .center)
        .padding()
    }

}

struct DifficultyViews_Previews: PreviewProvider {

    static var previews: some View {
        DifficultyViews(type: DifficultyModel.normal)
    }

}
