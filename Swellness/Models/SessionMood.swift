import Foundation

enum SessionMood: String, CaseIterable, Identifiable, Codable {
    case calm = "Calm"
    case energized = "Energized"
    case frustrated = "Frustrated"
    case free = "Free"
    case grounded = "Grounded"
    case tired = "Tired"
    case grateful = "Grateful"

    var id: String { rawValue }
}
