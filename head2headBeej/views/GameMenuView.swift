import SwiftUI

struct GameMenuView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @Binding var hasStarted: Bool
    var body: some View {
        VStack(spacing: 20) {
            if gameViewModel.gameManager.isGameOver, let winner = gameViewModel.gameManager.gameWinner {
                Text("\(winner.name) Wins!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding()
            }
            else {
                Text("Game Menu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding()
            }
            Button("Restart Game") {
                gameViewModel.restartGame()
                hasStarted = false
            }
            .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(
                    LinearGradient(
                        colors: [Color(red: 0.11, green: 0.47, blue: 0.88), Color(red: 0.05, green: 0.34, blue: 0.77)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    in: RoundedRectangle(cornerRadius: 22, style: .continuous)
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.6))
    }
}