

import Foundation

struct Player: Codable {
    var name: String
    var score: Int
    var currentHand: [Card]
    var hasAnAce: Bool {
        currentHand.contains(where: { $0.rank == .ace })
    }
    var aceValue: Int = 0
    var points: Int = 0
    var id: UUID = UUID()

    init(name: String) {
        self.name = name
        self.score = 0
        self.currentHand = []
    }
}