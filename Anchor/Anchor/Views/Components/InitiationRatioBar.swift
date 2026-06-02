import SwiftUI

struct InitiationRatioBar: View {
    let ratio: Double?  // 0.0 = all them, 1.0 = all you; nil = no data
    var height: CGFloat = 6
    var showLabels: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let ratio {
                if showLabels {
                    HStack {
                        Text("Them")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("You")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: height / 2)
                            .fill(Color(.systemGray5))
                            .frame(height: height)

                        RoundedRectangle(cornerRadius: height / 2)
                            .fill(ratioColor(ratio))
                            .frame(width: max(height, geo.size.width * ratio), height: height)
                    }
                }
                .frame(height: height)

                if showLabels {
                    HStack {
                        Spacer()
                        Text("\(Int(ratio * 100))% you")
                            .font(.caption2)
                            .foregroundStyle(ratioColor(ratio))
                            .fontWeight(.medium)
                    }
                }
            } else {
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(Color(.systemGray5))
                    .frame(height: height)

                if showLabels {
                    HStack {
                        Spacer()
                        Text("No data yet")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
        }
    }

    private func ratioColor(_ ratio: Double) -> Color {
        switch ratio {
        case ..<0.35: return AnchorColors.secure
        case 0.35..<0.65: return AnchorColors.neutral
        default: return AnchorColors.anxious
        }
    }
}

#Preview("Balanced") { InitiationRatioBar(ratio: 0.5).padding() }
#Preview("You initiate most") { InitiationRatioBar(ratio: 0.8).padding() }
#Preview("They initiate most") { InitiationRatioBar(ratio: 0.2).padding() }
#Preview("No data") { InitiationRatioBar(ratio: nil).padding() }
