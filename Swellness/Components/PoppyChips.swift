import SwiftUI

// MARK: - Mood grid

struct MoodChipGrid: View {
    @Binding var selection: SessionMood

    var body: some View {
        let columns = [GridItem(.adaptive(minimum: 104), spacing: 10)]
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(SessionMood.allCases) { mood in
                let pair = mood.popChipColors
                let isOn = selection == mood
                Button {
                    selection = mood
                } label: {
                    Text(mood.rawValue)
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.semibold)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.Swellness.plumInk)
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(chipFill(isOn: isOn, top: pair.0, bottom: pair.1))
                                .shadow(
                                    color: isOn ? pair.0.opacity(0.2) : Color.black.opacity(0.05),
                                    radius: isOn ? 8 : 6,
                                    y: isOn ? 4 : 3
                                )
                        }
                        .overlay {
                            chipOutline(isOn: isOn, cornerRadius: 20)
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func chipFill(isOn: Bool, top: Color, bottom: Color) -> AnyShapeStyle {
        if isOn {
            return AnyShapeStyle(
                LinearGradient(
                    colors: [top, bottom],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        return AnyShapeStyle(Color.Swellness.creamCard.opacity(0.9))
    }

    @ViewBuilder
    private func chipOutline(isOn: Bool, cornerRadius: CGFloat) -> some View {
        if isOn {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(Color.white.opacity(0.55), lineWidth: 1)
        } else {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.95),
                            Color.Swellness.popPink.opacity(0.28)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
    }
}

// MARK: - Energy row

struct EnergyChipRow: View {
    @Binding var selection: EnergyLevel

    var body: some View {
        HStack(spacing: 10) {
            ForEach(EnergyLevel.allCases) { level in
                let isOn = selection == level
                Button {
                    selection = level
                } label: {
                    Text(level.rawValue)
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundStyle(Color.Swellness.plumInk)
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(energyFill(isOn: isOn, level: level))
                                .shadow(
                                    color: isOn ? level.popChipColor.opacity(0.22) : Color.black.opacity(0.05),
                                    radius: isOn ? 8 : 6,
                                    y: isOn ? 4 : 3
                                )
                        }
                        .overlay {
                            energyOutline(isOn: isOn, cornerRadius: 20)
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func energyFill(isOn: Bool, level: EnergyLevel) -> AnyShapeStyle {
        if isOn {
            return AnyShapeStyle(
                LinearGradient(
                    colors: [level.popChipColor, level.popChipColorDeep],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        return AnyShapeStyle(Color.Swellness.creamCard.opacity(0.9))
    }

    @ViewBuilder
    private func energyOutline(isOn: Bool, cornerRadius: CGFloat) -> some View {
        if isOn {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(Color.white.opacity(0.55), lineWidth: 1)
        } else {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.92),
                            Color.Swellness.popSky.opacity(0.22)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 1
                )
        }
    }
}

// MARK: - Primary capsule (Save, etc.)

struct PoppyCapsuleButton: View {
    let title: String
    /// Default matches the original soft aqua “Save Session” look.
    var colors: [Color] = [Color.Swellness.aqua, Color.Swellness.oceanDeep]
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.headline, design: .rounded))
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(Color.white)
                .background {
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: colors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
        }
        .buttonStyle(.plain)
    }
}
