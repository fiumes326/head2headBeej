import SwiftUI

struct GameView: View {
	@EnvironmentObject var gameViewModel: GameViewModel
	@Binding var hasStarted: Bool

	var body: some View {
		ZStack {
			Color(hex: "#35654D")
				.ignoresSafeArea()

			VStack(spacing: 0) {
				VStack(spacing: 16) {
					Text("\(gameViewModel.otherPlayer.name) \(gameViewModel.otherPlayer.points)")
						.font(Font.custom("Arial Rounded MT Bold", size: 30))
						.frame(maxWidth: .infinity, alignment: .center)

					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing: 20) {
							ForEach(gameViewModel.otherPlayer.currentHand) { card in
								CardView(card: card)
							}
						}
						.frame(maxWidth: .infinity, alignment: .center)
						.padding(.horizontal, 16)
					}
				}
				.padding(.top, 20)

				Spacer()

				ActionsView(
					onSwipeLeft: gameViewModel.hit,
					onSwipeRight: {
						gameViewModel.stand()
					},
					onSwipeDown: gameViewModel.seePlayerCard,
					onSwipeUp: gameViewModel.hidePlayerCard
				)
				.frame(maxWidth: .infinity)
				.padding(.vertical, 16)

				Spacer()

				VStack(spacing: 16) {
                    HStack {
					    Text("\(gameViewModel.currentPlayer.name) \(gameViewModel.currentPlayer.points)")
						    .font(Font.custom("Arial Rounded MT Bold", size: 30))
						    .frame(maxWidth: .infinity, alignment: .center)

                        if gameViewModel.peeking {
                            Text("\(gameViewModel.currentPlayer.score)")
                                .font(Font.custom("Arial Rounded MT Bold", size: 20))
								.foregroundColor(Color(hex: "#1F3F31"))
								.padding(.horizontal, 14)
								.padding(.vertical, 8)
								.background(
									Capsule()
										.fill(Color.white.opacity(0.9))
								)
								.overlay(
									Capsule()
										.stroke(Color(hex: "#1F3F31").opacity(0.25), lineWidth: 1)
								)
								.shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
								.frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing: 20) {
							ForEach(gameViewModel.currentPlayer.currentHand) { card in
								CardView(card: card)
							}
						}
						.frame(maxWidth: .infinity, alignment: .center)
						.padding(.horizontal, 16)
					}
				}
				.padding(.bottom, 20)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)

			if gameViewModel.transfer {
				TransferView()
			}

			if gameViewModel.gameManager.isGameOver {
				GameMenuView(hasStarted: $hasStarted)
			} else if gameViewModel.winningView {
				WinningView()
			}
		}
	}
}

#Preview {
	GameViewPreviewContainer()
}

private struct GameViewPreviewContainer: View {
	@StateObject private var viewModel: GameViewModel = {
		let viewModel = GameViewModel()
		viewModel.deal()
		return viewModel
	}()

	var body: some View {
		GameView(hasStarted: .constant(true))
			.environmentObject(viewModel)
	}
}
