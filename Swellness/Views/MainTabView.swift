import SwiftUI

struct MainTabView: View {
    @Binding var showGoSurf: Bool
    @EnvironmentObject private var appState: AppStateViewModel
    @State private var tab: MainTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch tab {
                case .home:
                    HomeView {
                        appState.hasActiveSession = true
                        showGoSurf = true
                    }
                case .progress:
                    SurfProgressView()
                case .log:
                    QuickLogTabView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Spacer()
                FloatingGlassTabBar(selection: $tab)
                    .padding(.bottom, 6)
            }
            .allowsHitTesting(true)
        }
        .ignoresSafeArea(.keyboard)
    }
}
