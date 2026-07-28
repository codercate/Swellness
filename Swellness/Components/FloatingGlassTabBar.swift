import SwiftUI

enum MainTab: Int, CaseIterable, Identifiable {
    case home, progress, log

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .progress: return "Progress"
        case .log: return "Log"
        }
    }

    var symbol: String {
        switch self {
        case .home: return "house.fill"
        case .progress: return "leaf.fill"
        case .log: return "square.and.pencil"
        }
    }
}

struct FloatingGlassTabBar: View {
    @Binding var selection: MainTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases) { tab in
                tabButton(tab)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background {
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay {
                    Capsule()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.55),
                                    Color.Swellness.aqua.opacity(0.25)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
                .shadow(color: Color.black.opacity(0.08), radius: 20, y: 10)
        }
        .padding(.horizontal, 28)
    }

    private func tabButton(_ tab: MainTab) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                selection = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.symbol)
                    .font(.system(size: 18, weight: .medium))
                Text(tab.title)
                    .font(.system(size: 11, weight: .medium, design: .rounded))
            }
            .foregroundStyle(selection == tab ? Color.Swellness.textPrimary : Color.Swellness.textSecondary.opacity(0.75))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
