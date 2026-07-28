import SwiftUI

/// Third tab: same logging UI, opened voluntarily (no active-session requirement).
struct QuickLogTabView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @State private var mood: SessionMood = .calm
    @State private var energy: EnergyLevel = .medium
    @State private var notes: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                BeachBackgroundView()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        Text("Log a session")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.plumInk)
                            .padding(.top, 8)

                        Text("A quiet moment to remember how it felt — no scores, no pressure.")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.Swellness.plumInk.opacity(0.6))
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Mood")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.plumInk.opacity(0.65))
                        MoodChipGrid(selection: $mood)

                        Text("Energy")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.plumInk.opacity(0.65))
                        EnergyChipRow(selection: $energy)

                        Text("Notes (optional)")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.plumInk.opacity(0.65))
                        TextField("Waves, people, light…", text: $notes, axis: .vertical)
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.Swellness.plumInk)
                            .padding(16)
                            .background {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color.Swellness.creamCard.opacity(0.92))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .strokeBorder(
                                                LinearGradient(
                                                    colors: [
                                                        Color.white.opacity(0.9),
                                                        Color.Swellness.popSky.opacity(0.25)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1.5
                                            )
                                    }
                                    .shadow(color: Color.black.opacity(0.04), radius: 8, y: 4)
                            }

                        PoppyCapsuleButton(title: "Save Session") {
                            let session = SurfSession(mood: mood, energy: energy, notes: notes)
                            appState.saveSession(session)
                            notes = ""
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 120)
                    }
                    .padding(.horizontal, 22)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    QuickLogTabView()
        .environmentObject(AppStateViewModel())
}
