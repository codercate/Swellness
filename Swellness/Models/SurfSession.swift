import Foundation

enum EnergyLevel: String, CaseIterable, Identifiable, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"

    var id: String { rawValue }
}

struct SurfSession: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let mood: SessionMood
    let energy: EnergyLevel
    let notes: String

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        mood: SessionMood,
        energy: EnergyLevel,
        notes: String
    ) {
        self.id = id
        self.date = date
        self.mood = mood
        self.energy = energy
        self.notes = notes
    }
}
