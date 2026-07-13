

struct Player {
    var name: String
    var score: Int
    var currentHand: [Card]

    init(name: String) {
        self.name = name
        self.score = 0
        self.currentHand = []
    }
}