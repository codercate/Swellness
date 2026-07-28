import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    var onSurfTap: () -> Void

    var body: some View {
        ZStack {
            BeachBackgroundView()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    GlassBubble {
                        Text(appState.todayPrompt)
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.plumInk)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top, 8)

                    SoftCard {
                        Group {
                            if appState.currentStreakDays == 0 {
                                (Text("When you’re ready, your next ocean day will gently begin.") + Text(" 🌊"))
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.Swellness.plumInk.opacity(0.72))
                            } else {
                                HStack(alignment: .firstTextBaseline, spacing: 8) {
                                    Text("\(appState.currentStreakDays)")
                                        .font(.system(size: 36, weight: .semibold, design: .rounded))
                                        .foregroundStyle(Color.Swellness.popSkyDeep)
                                    (Text("day\(appState.currentStreakDays == 1 ? "" : "s") of choosing the ocean") + Text(" 🌊"))
                                        .font(.system(.body, design: .rounded))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.Swellness.plumInk.opacity(0.72))
                                }
                            }
                        }
                    }

                    SoftCard {
                        Text(appState.homeInsight)
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.Swellness.plumInk.opacity(0.72))
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    SoftCard {
                        Text("Cycle tip")
                            .font(.system(.caption, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Swellness.popPink)
                            .textCase(.uppercase)
                            .tracking(0.5)
                        Text(appState.cycleTipPlaceholder)
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.Swellness.plumInk)
                            .padding(.top, 6)
                    }

                    PrimarySurfButton(
                        title: "I’m going surfing",
                        subtitle: "It only takes a moment to begin."
                    ) {
                        onSurfTap()
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 120)
                }
                .padding(.horizontal, 22)
            }
        }
    }
}

#Preview {
    HomeView(onSurfTap: {})
        .environmentObject(AppStateViewModel())
}
