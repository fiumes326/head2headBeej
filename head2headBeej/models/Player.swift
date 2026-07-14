

import Foundation

struct Player: Codable {
    var name: String
    var score: Int
    var currentHand: [Card]
    var points: Int = 0
    var id: UUID = UUID()

    init(name: String) {
        self.name = name
        self.score = 0
        self.currentHand = []
    }
}