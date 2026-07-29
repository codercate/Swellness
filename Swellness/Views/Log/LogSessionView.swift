import SwiftUI

struct LogSessionView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var mood: SessionMood = .calm
    @State private var energy: EnergyLevel = .medium
    @State private var notes: String = ""
    @State private var showSkipFlow = false
    @State private var skipReason: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                BeachBackgroundView()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        Text("How did it feel?")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.plumInk)
                            .padding(.top, 8)

                        sectionTitle("Mood")
                        MoodChipGrid(selection: $mood)

                        sectionTitle("Energy")
                        EnergyChipRow(selection: $energy)

                        sectionTitle("Notes (optional)")
                        TextField("Anything you want to remember…", text: $notes, axis: .vertical)
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
                            dismiss()
                        }
                        .padding(.top, 8)

                        Button {
                            showSkipFlow = true
                        } label: {
                            Text("I didn’t surf")
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.Swellness.popLilac)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.plain)
                        .padding(.bottom, 32)
                    }
                    .padding(.horizontal, 22)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
            .sheet(isPresented: $showSkipFlow) {
                SkipSurfSheet(skipReason: $skipReason) {
                    appState.cancelActiveSession(skippedReason: skipReason)
                    skipReason = ""
                    showSkipFlow = false
                    dismiss()
                }
            }
        }
        .interactiveDismissDisabled()
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(.subheadline, design: .rounded))
            .fontWeight(.semibold)
            .foregroundStyle(Color.Swellness.plumInk.opacity(0.65))
    }
}

// MARK: - Skip flow

private struct SkipSurfSheet: View {
    @Binding var skipReason: String
    var onConfirm: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.Swellness.creamCard,
                        Color.Swellness.popLilacSoft.opacity(0.45),
                        Color.Swellness.popPinkSoft.opacity(0.35)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    Text("That’s okay.")
                        .font(.system(.caption, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.Swellness.popPink)
                        .textCase(.uppercase)
                        .tracking(0.6)

                    Text("The ocean will be there tomorrow.")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.Swellness.plumInk)
                        .fixedSize(horizontal: false, vertical: true)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Want to leave a gentle note? (optional)")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.plumInk.opacity(0.7))

                        TextField("Weather, timing, energy…", text: $skipReason, axis: .vertical)
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.Swellness.plumInk)
                            .padding(16)
                            .background {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .strokeBorder(Color.white.opacity(0.65), lineWidth: 1.5)
                                    }
                            }
                    }
                    .padding(18)
                    .background {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(Color.white.opacity(0.55))
                            .shadow(color: Color.Swellness.popPink.opacity(0.1), radius: 16, y: 8)
                    }

                    PoppyCapsuleButton(
                        title: "Close with kindness",
                        colors: [Color.Swellness.popPink, Color.Swellness.popCoral],
                        textColor: .white
                    ) {
                        onConfirm()
                    }

                    Spacer(minLength: 0)
                }
                .padding(24)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back") { dismiss() }
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.Swellness.popSkyDeep)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    LogSessionView()
        .environmentObject(AppStateViewModel())
}
