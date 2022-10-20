import Foundation

struct QuizModel: Decodable, Hashable {

    let category: String
    let description: String
    let difficulty: String
    let id: Int
    let imageUrl: String
    let name: String
    let numberOfQuestions: Int

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    static func == (lhs: QuizModel, rhs: QuizModel) -> Bool {
      lhs.id == rhs.id
    }

}
