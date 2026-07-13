import SwiftUI

struct GameView: View {
	let opponentName: String
	let myName: String
	let opponentCards: [Card]
	let myCards: [Card]
	var isUsersTurn: Bool = true
	var onHit: () -> Void = {}
	var onStand: () -> Void = {}


	var body: some View {
		ZStack {
			Color(red: 0.08, green: 0.45, blue: 0.18)
				.ignoresSafeArea()

			VStack(spacing: 20) {
				VStack(spacing: 8) {
					Text(opponentName)
						.font(.headline)
						.foregroundStyle(.white.opacity(0.9))
					if opponentCards.isEmpty {
						EmptyCardView(label: "No cards")
					} else {
						HStack(spacing: 12) {
							ForEach(opponentCards) { card in
								PlayingCardView(card: card)
							}
						}
					}

				}

				Spacer()

				if isUsersTurn {
					ActionsView(onHit: onHit, onStand: onStand)
				} else {
					Text("Opponent Turn")
						.font(.subheadline.weight(.semibold))
						.foregroundStyle(.white.opacity(0.9))
						.padding(.horizontal, 12)
						.padding(.vertical, 8)
						.background(.black.opacity(0.2), in: Capsule())
				}

				Spacer()

				VStack(alignment: .leading, spacing: 10) {
					Text(myName)
						.font(.headline)
						.foregroundStyle(.white.opacity(0.9))

					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing: 12) {
							if myCards.isEmpty {
								EmptyCardView(label: "No cards")
							} else {
								ForEach(myCards) { card in
									PlayingCardView(card: card)
								}
							}
						}
						.padding(.horizontal, 2)
					}
				}
			}
			.padding(16)
		}
	}
}

private struct PlayingCardView: View {
	let card: Card

	var body: some View {
		Group {
			if card.isFlipped {
				RoundedRectangle(cornerRadius: 12)
					.fill(.white)
					.overlay(alignment: .topLeading) {
						VStack(alignment: .leading, spacing: 2) {
							Text(rankText)
								.font(.system(size: 16, weight: .bold, design: .rounded))
							Text(card.suit.rawValue)
								.font(.system(size: 16))
						}
						.foregroundStyle(card.suitColor == .red ? Color.red : Color.black)
						.padding(8)
					}
			} else {
				RoundedRectangle(cornerRadius: 12)
					.fill(
						LinearGradient(
							colors: [Color.blue.opacity(0.9), Color.indigo.opacity(0.95)],
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						)
					)
					.overlay {
						RoundedRectangle(cornerRadius: 8)
							.strokeBorder(.white.opacity(0.7), lineWidth: 2)
							.padding(8)
					}
			}
		}
		.frame(width: 74, height: 106)
		.shadow(color: .black.opacity(0.22), radius: 5, x: 0, y: 3)
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

private struct EmptyCardView: View {
	let label: String

	var body: some View {
		RoundedRectangle(cornerRadius: 12)
			.strokeBorder(.white.opacity(0.7), lineWidth: 2)
			.frame(width: 74, height: 106)
			.overlay {
				Text(label)
					.font(.caption)
					.foregroundStyle(.white.opacity(0.85))
					.multilineTextAlignment(.center)
					.padding(6)
			}
	}
}

