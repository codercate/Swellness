import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var showGoSurf = false
    @State private var showLogSession = false

    var body: some View {
        MainTabView(showGoSurf: $showGoSurf)
            .fullScreenCover(isPresented: $showGoSurf) {
                GoSurfView()
                    .interactiveDismissDisabled(true)
            }
            .fullScreenCover(isPresented: $showLogSession) {
                LogSessionView()
                    .environmentObject(appState)
            }
            .onAppear {
                if appState.hasActiveSession {
                    showLogSession = true
                }
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                guard newPhase == .active, oldPhase != .active else { return }
                if appState.hasActiveSession, showGoSurf {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        showGoSurf = false
                        showLogSession = true
                    }
                }
            }
    }
}

#Preview {
    RootView()
        .environmentObject(AppStateViewModel())
}
