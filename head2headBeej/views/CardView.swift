import SwiftUI

struct CardView: View {
    var card: Card

    var body: some View {
        if card.isFlipped {
            VStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Text(rankText)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            Text(card.suit.rawValue)
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    )
            }
        } else {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 150)
                .cornerRadius(10)
                .overlay(
                    Rectangle()
                        .stroke(Color.white, lineWidth: 2)
                )
        }
    }

    private var rankText: String {
        switch card.rank {
        case .ace:
            return "A"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        default:
            return "\(card.rank.rawValue)"
        }
    }
}
