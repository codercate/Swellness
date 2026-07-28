import SwiftUI

extension SessionMood {
    /// Muted pastel gradients per mood (softer than the saturated “pop” set).
    var popChipColors: (Color, Color) {
        switch self {
        case .calm:
            return (
                Color(red: 0.82, green: 0.90, blue: 0.96),
                Color(red: 0.74, green: 0.86, blue: 0.92)
            )
        case .energized:
            return (
                Color(red: 0.96, green: 0.84, blue: 0.86),
                Color(red: 0.98, green: 0.88, blue: 0.82)
            )
        case .frustrated:
            return (
                Color(red: 0.94, green: 0.82, blue: 0.86),
                Color(red: 0.90, green: 0.78, blue: 0.84)
            )
        case .free:
            return (
                Color(red: 0.80, green: 0.90, blue: 0.95),
                Color(red: 0.82, green: 0.92, blue: 0.88)
            )
        case .grounded:
            return (
                Color(red: 0.80, green: 0.88, blue: 0.84),
                Color(red: 0.74, green: 0.84, blue: 0.80)
            )
        case .tired:
            return (
                Color(red: 0.88, green: 0.84, blue: 0.94),
                Color(red: 0.90, green: 0.86, blue: 0.96)
            )
        case .grateful:
            return (
                Color(red: 0.96, green: 0.86, blue: 0.90),
                Color(red: 0.98, green: 0.90, blue: 0.86)
            )
        }
    }
}

extension EnergyLevel {
    /// Muted pastels: low rose, medium butter, high sea-glass (still distinct).
    var popChipColor: Color {
        switch self {
        case .low: return Color(red: 0.94, green: 0.82, blue: 0.88)
        case .medium: return Color(red: 0.98, green: 0.91, blue: 0.76)
        case .high: return Color(red: 0.78, green: 0.90, blue: 0.84)
        }
    }

    var popChipColorDeep: Color {
        switch self {
        case .low: return Color(red: 0.90, green: 0.76, blue: 0.84)
        case .medium: return Color(red: 0.96, green: 0.86, blue: 0.70)
        case .high: return Color(red: 0.70, green: 0.84, blue: 0.78)
        }
    }
}
