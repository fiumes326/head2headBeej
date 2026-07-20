import SwiftUI

struct ActionsView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var onSwipeLeft: () -> Void
    var onSwipeRight: () -> Void
    var onSwipeDown: () -> Void
    var onSwipeUp: () -> Void

	var body: some View {
        GeometryReader { _ in
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    actionBadge(title: "Hit", systemImage: "arrow.left", tint: Color.green)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    actionBadge(title: "Stand", systemImage: "arrow.right", tint: Color.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Group {
                    if gameViewModel.peeking {
                        actionBadge(title: "Hide", systemImage: "arrow.up", tint: Color.yellow)
                    } else {
                        actionBadge(title: "Peek", systemImage: "arrow.down", tint: Color.yellow)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .highPriorityGesture(
            DragGesture(minimumDistance: 10)
                .onEnded { value in
                    let horizontalAmount = abs(value.translation.width)
                    let verticalAmount = abs(value.translation.height)

                    if verticalAmount > horizontalAmount {
                        if value.translation.height > 0 {
                            onSwipeDown()
                            gameViewModel.peeking = true
                        } else {
                            onSwipeUp()
                            gameViewModel.peeking = false
                        }
                    } else {
                        if value.translation.width < 0 {
                            onSwipeLeft()
                        } else if value.translation.width > 0 {
                            onSwipeRight()
                        }
                    }
            }
        )
        .background(Color.black.opacity(0.4))
    }

    private func actionBadge(title: String, systemImage: String, tint: Color) -> some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(tint.opacity(0.18))
                    .frame(width: 30, height: 30)

                Image(systemName: systemImage)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(tint.opacity(0.95))
            }

            Text(title)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white.opacity(0.94))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(tint.opacity(0.18))
        )
        .gesture(
            TapGesture()
                .onEnded {
                    switch title {
                    case "Hit":
                        onSwipeLeft()
                    case "Stand":
                        onSwipeRight()
                    case "Peek":
                        onSwipeDown()
                        gameViewModel.peeking = true
                    case "Hide":
                        onSwipeUp()
                        gameViewModel.peeking = false
                    default:
                        break
                    }
                }
        )
    }
}
