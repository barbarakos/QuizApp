import Foundation

struct QuizModel: Decodable {

    let category: String
    let description: String
    let difficulty: String
    let id: Int
    let imageUrl: String
    let name: String
    let numberOfQuestions: Int

}
