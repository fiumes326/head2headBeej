import SwiftUI


struct WinningView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var body: some View {
        VStack {
            Text("Winner!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding()
            Text("\(gameViewModel.RoundWinner?.name ?? "") wins with \(gameViewModel.RoundWinner?.score ?? 0) points!")
                .font(.title)
                .foregroundStyle(Color.white)
                .padding()
            Button("Start Next Round") {
                gameViewModel.deal()
                gameViewModel.RoundWinner = nil
                gameViewModel.winningView = false
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