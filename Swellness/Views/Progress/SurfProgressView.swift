import SwiftUI

struct SurfProgressView: View {
    @EnvironmentObject private var appState: AppStateViewModel

    var body: some View {
        ZStack {
            BeachBackgroundView()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Progress")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.Swellness.plumInk)
                        .padding(.top, 12)

                    SoftCard {
                        statRow(title: "Total sessions", value: "\(appState.totalSessions)")
                    }

                    SoftCard {
                        statRow(title: "Current streak", value: "\(appState.currentStreakDays) day\(appState.currentStreakDays == 1 ? "" : "s")")
                    }

                    SoftCard {
                        VStack(alignment: .leading, spacing: 14) {
                            Text(monthlyLine)
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.Swellness.plumInk.opacity(0.72))
                                .fixedSize(horizontal: false, vertical: true)

                            Divider()
                                .overlay(Color.Swellness.plumInk.opacity(0.1))

                            Text(appState.progressInsight)
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.Swellness.plumInk.opacity(0.72))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 22)
            }
        }
    }

    private var monthlyLine: String {
        let n = appState.sessionsThisMonth
        if n == 0 {
            return "You haven’t logged a session this month yet — and that’s alright."
        }
        return "You’ve surfed \(n) time\(n == 1 ? "" : "s") this month."
    }

    private func statRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(.caption, design: .rounded))
                .fontWeight(.semibold)
                .foregroundStyle(Color.Swellness.popPink.opacity(0.88))
            Text(value)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.semibold)
                .foregroundStyle(Color.Swellness.plumInk)
        }
    }
}

#Preview {
    SurfProgressView()
        .environmentObject(AppStateViewModel())
}
