//
//  ContentView.swift
//  head2headBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/13/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView(
            opponentName: "Opponent",
            myName: "Me",
            opponentCards: [
                Card(rank: .ace, suit: .spades, suitColor: .black, isFlipped: true),
                Card(rank: .king, suit: .hearts, suitColor: .red, isFlipped: false)
            ],
            myCards: [
                Card(rank: .queen, suit: .diamonds, suitColor: .red, isFlipped: true),
                Card(rank: .jack, suit: .clubs, suitColor: .black, isFlipped: false),
                Card(rank: .ten, suit: .spades, suitColor: .black, isFlipped: false)
            ]
        )
    }
}

#Preview {
    ContentView()
}
