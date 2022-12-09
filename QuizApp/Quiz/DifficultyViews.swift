import SwiftUI

struct DifficultyViews: View {

    private let emptyFillColor = Color(white: 1).opacity(0.7)

    private let view1: Color!
    private let view2: Color!
    private let view3: Color!

    init(type: DifficultyModel) {
        switch type {
        case .easy:
            view1 = .yellow
            view2 = emptyFillColor
            view3 = emptyFillColor
        case .normal:
            view1 = .yellow
            view2 = .yellow
            view3 = emptyFillColor
        case .hard:
            view1 = .yellow
            view2 = .yellow
            view3 = .yellow
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 2)
                .rotation(Angle(degrees: 45))
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(view1)
            RoundedRectangle(cornerRadius: 2)
                .rotation(Angle(degrees: 45))
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(view2)
            RoundedRectangle(cornerRadius: 2)
                .rotation(Angle(degrees: 45))
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(view3)
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
