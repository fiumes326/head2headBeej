import SwiftUI

struct GameView: View {
	@EnvironmentObject var gameViewModel: GameViewModel

	var body: some View {
		ZStack {
			Color(hex: "#35654D")
				.ignoresSafeArea()

			VStack(spacing: 0) {
				VStack(spacing: 16) {
					Text(gameViewModel.otherPlayer.name)
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
					Text(gameViewModel.currentPlayer.name)
						.font(Font.custom("Arial Rounded MT Bold", size: 30))
						.frame(maxWidth: .infinity, alignment: .center)

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

            if gameViewModel.winningView {
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
		GameView()
			.environmentObject(viewModel)
	}
}
