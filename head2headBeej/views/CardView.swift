import SwiftUI

struct CardView: View {
    var card: Card

    var body: some View {
        if card.isFlipped {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.white, Color(red: 0.96, green: 0.96, blue: 0.98)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.black.opacity(0.18), lineWidth: 3)
                    )

                Text(card.suit.rawValue)
                    .font(.system(size: 26))
                    .padding(.top, 10)
                    .padding(.leading, 10)

                Text(rankText)
                    .font(Font.custom("Arial Rounded MT Bold", size: 50))
                    .foregroundColor(rankColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 100, height: 150)
            .shadow(color: .black.opacity(0.18), radius: 5, x: 0, y: 3)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.22, green: 0.40, blue: 0.92), Color(red: 0.09, green: 0.23, blue: 0.63)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.9), lineWidth: 2)
                    )

                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.white.opacity(0.55), lineWidth: 2)
                    .padding(10)
            }
                .frame(width: 100, height: 150)
                .shadow(color: .black.opacity(0.18), radius: 5, x: 0, y: 3)
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

    private var rankColor: Color {
        card.suitColor == .red ? Color(red: 0.84, green: 0.15, blue: 0.20) : Color.black
    }
}
