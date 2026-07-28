import SwiftUI

struct GoSurfView: View {
    @State private var appeared = false

    var body: some View {
        ZStack {
            OceanAerialBackgroundView()

            VStack(spacing: 14) {
                Text("Go surf.")
                    .font(.system(size: 34, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.white.opacity(0.95))
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 8)

                Text("We’ll be here 🌊")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.white.opacity(0.78))
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 6)
            }
            .multilineTextAlignment(.center)
            .padding(32)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.9)) {
                appeared = true
            }
        }
    }
}

#Preview {
    GoSurfView()
}
