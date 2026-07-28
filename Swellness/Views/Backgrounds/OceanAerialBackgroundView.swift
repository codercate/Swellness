import SwiftUI

/// Go Surf — same illustration with a cool aqua veil and slow ripples so it still feels vast and watery.
struct OceanAerialBackgroundView: View {
    @State private var ripple = false

    var body: some View {
        ZStack {
            BeachIllustrationLayer()

            LinearGradient(
                colors: [
                    Color.Swellness.oceanLight.opacity(0.35),
                    Color.Swellness.aqua.opacity(0.42),
                    Color.Swellness.oceanDeep.opacity(0.38),
                    Color.Swellness.deepAqua.opacity(0.45)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .stroke(Color.white.opacity(0.14), lineWidth: 1.5)
                .scaleEffect(ripple ? 1.45 : 0.82)
                .opacity(ripple ? 0.12 : 0.38)
                .animation(.easeInOut(duration: 5.5).repeatForever(autoreverses: true), value: ripple)

            Circle()
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
                .scaleEffect(ripple ? 1.15 : 0.72)
                .opacity(ripple ? 0.28 : 0.12)
                .animation(.easeInOut(duration: 5.5).delay(0.9).repeatForever(autoreverses: true), value: ripple)
        }
        .onAppear { ripple = true }
    }
}
