import Foundation
import SwiftUI

/// Central app state + session persistence. Uses `UserDefaults` (same idea as `@AppStorage`).
final class AppStateViewModel: ObservableObject {
    private enum Keys {
        static let activeSession = "hasActiveSession"
        static let sessions = "savedSurfSessions"
    }

    private let defaults = UserDefaults.standard

    /// Mirrors `@AppStorage("hasActiveSession")` — true after "I'm going surfing" until log completes.
    @Published var hasActiveSession: Bool {
        didSet { defaults.set(hasActiveSession, forKey: Keys.activeSession) }
    }

    @Published private(set) var sessions: [SurfSession] = []

    init() {
        hasActiveSession = defaults.bool(forKey: Keys.activeSession)
        if let data = defaults.data(forKey: Keys.sessions),
           let decoded = try? JSONDecoder().decode([SurfSession].self, from: data) {
            sessions = decoded.sorted { $0.date > $1.date }
        }
    }

    func saveSession(_ session: SurfSession) {
        sessions.insert(session, at: 0)
        persistSessions()
        hasActiveSession = false
    }

    func cancelActiveSession(skippedReason: String?) {
        if let reason = skippedReason?.trimmingCharacters(in: .whitespacesAndNewlines), !reason.isEmpty {
            // Optional: could append a lightweight "skipped" record later; keep simple for now.
            _ = reason
        }
        hasActiveSession = false
    }

    private func persistSessions() {
        if let data = try? JSONEncoder().encode(sessions) {
            defaults.set(data, forKey: Keys.sessions)
        }
    }

    // MARK: - Derived insights (gentle, text-only)

    var currentStreakDays: Int {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        if hasSession(on: today) { return countStreak(from: today) }
        if let yesterday = cal.date(byAdding: .day, value: -1, to: today), hasSession(on: yesterday) {
            return countStreak(from: yesterday)
        }
        return 0
    }

    var totalSessions: Int { sessions.count }

    var sessionsThisMonth: Int {
        let cal = Calendar.current
        return sessions.filter { cal.isDate($0.date, equalTo: Date(), toGranularity: .month) }.count
    }

    private func hasSession(on day: Date) -> Bool {
        let cal = Calendar.current
        let d = cal.startOfDay(for: day)
        return sessions.contains { cal.isDate($0.date, inSameDayAs: d) }
    }

    private func countStreak(from end: Date) -> Int {
        let cal = Calendar.current
        var streak = 0
        var cursor = cal.startOfDay(for: end)
        let sessionDays = Set(sessions.map { cal.startOfDay(for: $0.date) })
        while sessionDays.contains(cursor) {
            streak += 1
            guard let prev = cal.date(byAdding: .day, value: -1, to: cursor) else { break }
            cursor = prev
        }
        return streak
    }

    var homeInsight: String {
        if sessions.count < 2 {
            return "Every time you choose the water, you’re choosing yourself."
        }
        let weekdayCounts = Dictionary(grouping: sessions, by: { Calendar.current.component(.weekday, from: $0.date) })
            .mapValues { $0.count }
        if let best = weekdayCounts.max(by: { $0.value < $1.value }),
           let name = Calendar.current.weekdaySymbols[safe: best.key - 1] {
            return "You often feel drawn to the ocean around \(name)s."
        }
        return "Your rhythm is yours — there’s no wrong way to show up."
    }

    var progressInsight: String {
        if sessionsThisMonth == 0 {
            return "The ocean isn’t going anywhere. You’ll find your way back when it feels right."
        }
        if sessionsThisMonth >= 2 {
            return "You tend to feel more grounded after a few dips in the same week."
        }
        return "You’ve surfed \(sessionsThisMonth) time\(sessionsThisMonth == 1 ? "" : "s") this month — gentle and enough."
    }

    var cycleTipPlaceholder: String {
        "You might feel a little more energized today."
    }

    static let motivationPrompts: [String] = [
        "Show up for the things that make you feel alive.",
        "The ocean doesn’t ask you to be perfect — only present.",
        "Small steps toward the water still count as courage.",
        "Freedom often starts with one honest yes to yourself."
    ]

    var todayPrompt: String {
        let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        return Self.motivationPrompts[day % Self.motivationPrompts.count]
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
