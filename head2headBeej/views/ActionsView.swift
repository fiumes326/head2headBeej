import SwiftUI

struct ActionsView: View {
	let onHit: () -> Void
	let onStand: () -> Void

	var body: some View {
		HStack(spacing: 14) {
			Button(action: onHit) {
				Label("Swipe Right • Hit", systemImage: "arrow.right.circle.fill")
					.font(.subheadline.weight(.semibold))
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
					.padding(.vertical, 12)
					.background(
						RoundedRectangle(cornerRadius: 12)
							.fill(Color.orange.opacity(0.95))
					)
			}

			Button(action: onStand) {
				Label("Swipe Left • Stand", systemImage: "arrow.left.circle.fill")
					.font(.subheadline.weight(.semibold))
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
					.padding(.vertical, 12)
					.background(
						RoundedRectangle(cornerRadius: 12)
							.fill(Color.blue.opacity(0.95))
					)
			}
		}
		.padding(.horizontal, 8)
	}
}

#Preview {
	ZStack {
		Color(red: 0.08, green: 0.45, blue: 0.18).ignoresSafeArea()
		ActionsView(onHit: {}, onStand: {})
			.padding()
	}
}