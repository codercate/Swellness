import SwiftUI

/// Full-bleed beach illustration from the asset catalog (`BeachIllustration`).
struct BeachIllustrationLayer: View {
    var body: some View {
        Image("BeachIllustration")
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .clipped()
            .ignoresSafeArea()
    }
}

/// Home, Log, Progress — art plus a soft wash so cards and type stay readable.
struct BeachBackgroundView: View {
    var body: some View {
        BeachIllustrationLayer()
            .overlay {
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.42),
                        Color.Swellness.lilac.opacity(0.18),
                        Color.Swellness.sky.opacity(0.12),
                        Color.black.opacity(0.06)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
    }
}
