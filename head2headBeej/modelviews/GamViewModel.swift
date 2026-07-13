import Combine
import Foundation

final class GameViewModel: ObservableObject {
    @Published var gameScore = GameScore()
    @Published var deck: Deck = Deck()
    @Published var player1: Player = Player(name: "Player 1")
    @Published var player2: Player = Player(name: "Player 2")

    
    
}
