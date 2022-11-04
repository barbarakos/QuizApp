import Foundation

struct QuizResponseModel: Decodable, Hashable {

    let id: Int
    let category: String
    let description: String
    let difficulty: DifficultyResponseModel
    let imageUrl: String
    let name: String
    let numberOfQuestions: Int

}
