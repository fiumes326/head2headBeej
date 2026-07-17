import SwiftUI
import Combine
import Foundation

final class GameViewModel: ObservableObject {
    @Published var gameManager = GameManager()
    @Published var deck: Deck = Deck()
    @Published var transfer = false
    @Published var peeking = false
    @Published var winningView = false
    @Published var RoundWinner: Player? = nil

    var currentPlayerIndex: Int {
        gameManager.players.firstIndex(where: { $0.id == gameManager.whoTurns }) ?? 0
    }

    var otherPlayerIndex: Int {
        currentPlayerIndex == 0 ? 1 : 0
    }

    var currentPlayer: Player {
        gameManager.players[currentPlayerIndex]
    }

    var otherPlayer: Player {
        gameManager.players[otherPlayerIndex]
    }

    func deal() {
        guard let startIndex = gameManager.players.firstIndex(where: { $0.id == gameManager.whoTurns }) else {
            return
        }

        for index in gameManager.players.indices {
            gameManager.players[index].currentHand.removeAll()
            gameManager.players[index].score = 0
        }
        
        for i in 0..<gameManager.players.count * 2 {
            let playerIndex = (startIndex + i) % gameManager.players.count
            if var card = deck.deal() {
                card.isFlipped = i > gameManager.players.count - 1 //flip everyone's second card
                gameManager.players[playerIndex].currentHand.append(card)
                switch card.rank {
                case .ace:
                    if gameManager.players[playerIndex].score + 11 <= 21 {
                        gameManager.players[playerIndex].score += 11
                        gameManager.players[playerIndex].aceValue = 11
                    } else {
                        gameManager.players[playerIndex].score += 1
                        gameManager.players[playerIndex].aceValue = 1
                    }
                case .jack, .queen, .king:
                    gameManager.players[playerIndex].score += 10
                default:
                    gameManager.players[playerIndex].score += card.rank.rawValue
                }
            }
        }
    }

    func hit() {
        guard let drawnCard = deck.deal() else { return }
        guard let currentPlayerIndex = gameManager.players.firstIndex(where: { $0.id == gameManager.whoTurns }) else {
            return
        }
        gameManager.players[currentPlayerIndex].currentHand.append(drawnCard)
        switch drawnCard.rank {
        case .ace:
            if gameManager.players[currentPlayerIndex].score + 11 <= 21 {
                gameManager.players[currentPlayerIndex].score += 11
                gameManager.players[currentPlayerIndex].aceValue = 11
            } else {
                gameManager.players[currentPlayerIndex].score += 1
                gameManager.players[currentPlayerIndex].aceValue = 1
            }
        case .jack, .queen, .king:
            gameManager.players[currentPlayerIndex].score += 10
        default:
            gameManager.players[currentPlayerIndex].score += drawnCard.rank.rawValue
        }

        if gameManager.players[currentPlayerIndex].hasAnAce && gameManager.players[currentPlayerIndex].aceValue == 11 && gameManager.players[currentPlayerIndex].score > 21 {
            gameManager.players[currentPlayerIndex].score -= 10
            gameManager.players[currentPlayerIndex].aceValue = 1
        }
    
    }

    func stand() {
        if gameManager.dealFirst == gameManager.whoTurns {
            hidePlayerCard()
            guard let currentPlayerIndex = gameManager.players.firstIndex(where: { $0.id == gameManager.whoTurns }) else {
                return
            }
            let nextPlayerIndex = (currentPlayerIndex + 1) % gameManager.players.count
            gameManager.whoTurns = gameManager.players[nextPlayerIndex].id
            transfer = true
            }
        else {
            hidePlayerCard()
            let winner = gameManager.checkWinner()
            if winner == nil {
                // It's a tie, change deal first and start new round
                gameManager.dealFirst = gameManager.players.first(where: { $0.id != gameManager.dealFirst })?.id ?? gameManager.dealFirst
                gameManager.whoTurns = gameManager.dealFirst
                deal()
            }
            else {
                gameManager.playerWin(player: winner!.id)
                if isGameOver() {
                    gameManager.isGameOver = true
                    gameManager.gameWinner = winner
                    winningView = false
                    transfer = false
                    peeking = false
                    return
                }
                RoundWinner = winner
                winningView = true

                // Prepare next round to start with the other player.
                gameManager.dealFirst = gameManager.players.first(where: { $0.id != gameManager.dealFirst })?.id ?? gameManager.dealFirst
                gameManager.whoTurns = gameManager.dealFirst
            }
        }
    }

    func isGameOver() -> Bool {
        return gameManager.players.contains(where: { $0.points > gameManager.bestOf/2 })
    }
    
    func seePlayerCard() {
        guard let currentPlayerIndex = gameManager.players.firstIndex(where: { $0.id == gameManager.whoTurns }) else {
            return
        }
        guard !gameManager.players[currentPlayerIndex].currentHand.isEmpty else {
            return
        }
        gameManager.players[currentPlayerIndex].currentHand[0].isFlipped = true
        peeking = true
    }
    
    func hidePlayerCard() {
        guard let currentPlayerIndex = gameManager.players.firstIndex(where:{ $0.id == gameManager.whoTurns}) else {
            return
        }
        guard !gameManager.players[currentPlayerIndex].currentHand.isEmpty else {
            return
        }
        gameManager.players[currentPlayerIndex].currentHand[0].isFlipped = false
        peeking = false
    }

    func getCurrentPlayer() -> Player? {
        return gameManager.players.first(where: { $0.id == gameManager.whoTurns })
    }

    func restartGame() {
        gameManager = GameManager()
        deck = Deck()
        deal()
        transfer = false
        peeking = false
        winningView = false
        RoundWinner = nil
    }
}
