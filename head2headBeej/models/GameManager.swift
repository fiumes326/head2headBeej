//
//  GameScore.swift
//  headtoheadBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/9/26.
//

import Foundation

struct GameManager: Codable {
    var players: [Player] = []
    var bestOf: Int
    var isGameOver: Bool
    var whoTurns: UUID
    var dealFirst: UUID
    
    init() {
        self.bestOf = 3
        self.isGameOver = false
        self.players = [Player(name: "Player1"), Player(name: "Player2")]
        self.whoTurns = self.players[0].id
        self.dealFirst = self.players[0].id
    }
    
    mutating func playerWin(player: UUID) {
        guard let playerIndex = players.firstIndex(where: { $0.id == player }) else { return }
        players[playerIndex].points += 1
    }

    func checkWinner() -> Player? {
        var bestScore = -1
        var winner: Player? = nil
        var tie = false

        for player in players {
            if player.score > 21 {
                continue
            }

            if player.score > bestScore {
                bestScore = player.score
                winner = player
                tie = false
            } else if player.score == bestScore {
                tie = true
            }
        }

        return tie ? nil : winner
    }


}
