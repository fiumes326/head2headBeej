import SwiftUI

struct PlayerSetupView: View {
    @State private var bestOf = 3
    @State private var player1Name = ""
    @State private var player2Name = ""
    @Binding var hasStarted: Bool
    @EnvironmentObject var gameViewModel: GameViewModel

    private var canStart: Bool {
        !player1Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !player2Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.04, green: 0.24, blue: 0.13), Color(red: 0.02, green: 0.17, blue: 0.09)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
                .ignoresSafeArea()

            VStack(spacing: 22) {
                Text("Head2Head Beej")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Enter player names to begin")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))

                Text("Player 1")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.85))
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextField(
                    "",
                    text: $player1Name,
                    prompt: Text("Name").foregroundStyle(.black.opacity(0.5))
                )
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .foregroundStyle(.black)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.96), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(.white.opacity(0.18), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.14), radius: 8, x: 0, y: 4)

                Text("Player 2")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.85))
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextField(
                    "",
                    text: $player2Name,
                    prompt: Text("Name").foregroundStyle(.black.opacity(0.5))
                )
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .foregroundStyle(.black)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.96), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(.white.opacity(0.18), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.14), radius: 8, x: 0, y: 4)

                Picker("Best of", selection: $bestOf) {
                    Text("Best of 3").tag(3)
                    Text("Best of 5").tag(5)
                    Text("Best of 7").tag(7)
                }
                .pickerStyle(.segmented)

                Button {
                    gameViewModel.gameManager.players[0].name = player1Name
                    gameViewModel.gameManager.players[1].name = player2Name
                    gameViewModel.gameManager.bestOf = bestOf
                    gameViewModel.deal()
                    hasStarted = true
                } label: {
                    Text("Start Game")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(
                            LinearGradient(
                                colors: canStart ? [Color(red: 0.11, green: 0.47, blue: 0.88), Color(red: 0.05, green: 0.34, blue: 0.77)] : [Color.gray.opacity(0.5), Color.gray.opacity(0.4)],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            in: RoundedRectangle(cornerRadius: 22, style: .continuous)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                }
                .buttonStyle(.plain)
                .disabled(!canStart)

                .padding(.top, 10)

                
                
                
                

                
            }
            .padding(24)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 10)
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    PlayerSetupView(hasStarted: .constant(false))
        .environmentObject(GameViewModel())
}



