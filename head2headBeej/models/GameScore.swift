//
//  GameScore.swift
//  headtoheadBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/9/26.
//

struct GameScore: Codable {
    var player1Points: Int
    var player2Points: Int
    var bestOf: Int
    var isGameOver: Bool
    var whoTurns: Int = 1 // 1 for player 1, 2 for player 2
    
    init() {
        self.player1Points = 0
        self.player2Points = 0
        self.bestOf = 3
        self.isGameOver = false
    }
    
    mutating func playerWin(player: Int) {
        if player == 1 {
            self.player1Points += 1
        }
        
        if player == 2 {
            self.player2Points += 1
        }
    }

}
