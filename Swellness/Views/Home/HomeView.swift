import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    var onSurfTap: () -> Void

    var body: some View {
        ZStack {
            BeachBackgroundView()

            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        GlassBubble {
                            Text(appState.todayPrompt)
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.Swellness.plumInk)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.top, 8)

                        SoftCard {
                            VStack(alignment: .leading, spacing: 14) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(appState.currentStreakDays == 0 ? "Ready when you are" : "Current streak")
                                        .font(.system(.caption2, design: .rounded))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.Swellness.plumInk.opacity(0.6))
                                        .textCase(.uppercase)
                                        .tracking(0.5)

                                    if appState.currentStreakDays == 0 {
                                        (Text("Your next ocean day will gently begin.") + Text(" 🌊"))
                                            .font(.system(.subheadline, design: .rounded))
                                            .fontWeight(.medium)
                                            .foregroundStyle(Color.Swellness.plumInk.opacity(0.72))
                                    } else {
                                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                                            Text("\(appState.currentStreakDays)")
                                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                                .foregroundStyle(Color.Swellness.popPinkDeep)
                                            (Text("day\(appState.currentStreakDays == 1 ? "" : "s") of choosing the ocean") + Text(" 🌊"))
                                                .font(.system(.body, design: .rounded))
                                                .fontWeight(.medium)
                                                .foregroundStyle(Color.Swellness.plumInk.opacity(0.75))
                                        }
                                    }
                                }

                                Divider()
                                    .overlay(Color.Swellness.plumInk.opacity(0.1))

                                Text(appState.homeInsight)
                                    .font(.system(.subheadline, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.Swellness.plumInk.opacity(0.72))
                                    .fixedSize(horizontal: false, vertical: true)

                                Divider()
                                    .overlay(Color.Swellness.plumInk.opacity(0.1))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Cycle tip")
                                        .font(.system(.caption2, design: .rounded))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.Swellness.popPink)
                                        .textCase(.uppercase)
                                        .tracking(0.5)
                                    Text(appState.cycleTipPlaceholder)
                                        .font(.system(.subheadline, design: .rounded))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.Swellness.plumInk)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                }

                PrimarySurfButton(
                    title: "I’m going surfing",
                    subtitle: "It only takes a moment to begin."
                ) {
                    onSurfTap()
                }
                .padding(.horizontal, 22)
                .padding(.top, 16)
                .padding(.bottom, 104)
            }
        }
    }
}

#Preview {
    HomeView(onSurfTap: {})
        .environmentObject(AppStateViewModel())
}
