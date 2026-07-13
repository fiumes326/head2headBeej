//
//  Deck.swift
//  headtoheadBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/9/26.
//

import Foundation

struct Deck {
    var id: UUID = UUID()
    private var deck: [Card]

    init() {
        self.deck = Deck.makeShuffledDeck()
    }
    
    mutating func ResetAndShuffle() {
        self.deck = Deck.makeShuffledDeck()
    }

    private static func makeShuffledDeck() -> [Card] {
        var newDeck: [Card] = []
            for suit in Card.Suit.allCases {
                for rank in Card.Rank.allCases {
                    var color: Card.SuitColor
                    if suit == .spades || suit == .clubs {
                        color = .black
                    }
                    else {
                        color = .red
                    }
                    newDeck.append(Card(rank: rank, suit: suit, suitColor: color, isFlipped: false))
                }
            }

            return newDeck.shuffled()
    }
    
    mutating func deal() -> Card? {
        return deck.popLast()
    }
}
