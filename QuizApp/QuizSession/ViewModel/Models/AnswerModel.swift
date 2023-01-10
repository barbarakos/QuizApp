import SwiftUI

struct AnswerModel: Identifiable {

    let id: Int
    let index: Int
    let answer: String
    var color: Color

}

extension AnswerModel {

    init(from model: AnswerUseCaseModel, index: Int) {
        id = model.id
        self.index = index
        answer = model.answer
        color = .white.opacity(0.3)
    }

}
