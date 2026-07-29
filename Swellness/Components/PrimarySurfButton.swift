import SwiftUI

struct PrimarySurfButton: View {
    let title: String
    let subtitle: String
    let action: () -> Void

    @State private var breathe = false

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(title)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.medium)
                Text(subtitle)
                    .font(.system(.footnote, design: .rounded))
                    .fontWeight(.medium)
                    .opacity(0.9)
            }
            .foregroundStyle(Color.Swellness.plumInk)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background {
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.Swellness.blush, Color.Swellness.peach],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(
                        color: Color.Swellness.coral.opacity(breathe ? 0.45 : 0.25),
                        radius: breathe ? 20 : 12,
                        y: breathe ? 10 : 6
                    )
            }
            .scaleEffect(breathe ? 1.02 : 1.0)
        }
        .buttonStyle(.plain)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.8).repeatForever(autoreverses: true)) {
                breathe = true
            }
        }
    }
}
