import Foundation

struct JokeModel: Codable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}
