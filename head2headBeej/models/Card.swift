//
//  Card.swift
//  headtoheadBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/9/26.
//

import Foundation

struct Card: Codable, Identifiable {
    var id: UUID = UUID()
    var rank: Rank
    var suit: Suit
    var suitColor: SuitColor
    var isFlipped: Bool
    
    enum Rank: Int, Codable, CaseIterable {
        case ace = 1
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
    }
    
    enum Suit: String, Codable, CaseIterable {
        case hearts = "❤️"
        case diamonds = "♦️"
        case clubs = "♣️"
        case spades = "♠️"
    }
    
    enum SuitColor: String, Codable {
        case red
        case black
    }
    
    mutating func flip() {
        isFlipped.toggle()
    }
    
    
    
    
}
