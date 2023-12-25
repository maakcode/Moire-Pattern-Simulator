//Copyright © 2023 MaakCode. All rights reserved.

import SwiftUI

struct SettingView: View {
    @Binding var zoomLevel: CGFloat
    @Binding var baseSize: CGFloat
    @Binding var baseSpacing: CGFloat
    @Binding var shape: PatternCanvasView.PatternShape
    @Binding var isFilled: Bool

    var body: some View {
        ScrollView {
            VStack {
                SectionItem("Zoom Level") {
                    HStack {
                        Text(zoomLevel.formatted())
                        Slider(value: $zoomLevel, in: 0.5...1.5, step: 0.01)
                    }
                }
                SectionItem("Size") {
                    HStack {
                        Text(baseSize.formatted())
                        Slider(value: $baseSize, in: 5...30, step: 5)
                    }
                }
                SectionItem("Spacing") {
                    HStack {
                        Text(baseSpacing.formatted())
                        Slider(value: $baseSpacing, in: 0...30, step: 5)
                    }
                }
                SectionItem("Shape") {
                    Picker("Shape", selection: $shape) {
                        ForEach(PatternCanvasView.PatternShape.allCases) {patternShape in
                            Text(patternShape.rawValue).tag(patternShape)
                        }
                    }
                    .pickerStyle(.segmented)
                    Toggle("Fill", isOn: $isFilled)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    private func SectionItem(_ title: String, @ViewBuilder contents: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 15)
            VStack {
                contents()
            }
            .padding()
            .background(in: RoundedRectangle(cornerRadius: 15, style: .continuous), fillStyle: FillStyle())
        }
        .padding(.vertical, 10)
    }
}



#Preview {
    SettingView(zoomLevel: .constant(1), baseSize: .constant(10), baseSpacing: .constant(10), shape: .constant(.circle), isFilled: .constant(true))
}
