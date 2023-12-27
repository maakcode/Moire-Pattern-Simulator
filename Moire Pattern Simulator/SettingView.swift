//Copyright © 2023 MaakCode. All rights reserved.

import SwiftUI

struct SettingView: View {
    @Binding var zoomLevel: CGFloat
    @Binding var baseSize: CGFloat
    @Binding var baseSpacing: CGFloat
    @Binding var shape: PatternCanvasView.PatternShape
    @Binding var isFilled: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section("Zoom Level") {
                    Slider(value: $zoomLevel, in: 0.5...1.5, step: 0.01) {
                        EmptyView()
                    } minimumValueLabel: {
                        Text(zoomLevel.formatted())
                    } maximumValueLabel: {
                        Text("")
                    }
                }
                Section("Size") {
                    Slider(value: $baseSize, in: 2...20, step: 2) {
                        EmptyView()
                    } minimumValueLabel: {
                        Text(baseSize.formatted())
                    } maximumValueLabel: {
                        Text("")
                    }
                }
                Section("Spacing") {
                    Slider(value: $baseSpacing, in: 0...20, step: 2) {
                        EmptyView()
                    } minimumValueLabel: {
                        Text(baseSpacing.formatted())
                    } maximumValueLabel: {
                        Text("")
                    }
                }
                Section("Shape") {
                    Picker("Shape", selection: $shape) {
                        ForEach(PatternCanvasView.PatternShape.allCases) { patternShape in
                            Text(patternShape.rawValue).tag(patternShape)
                        }
                    }
                    .pickerStyle(.segmented)
                    Toggle("Fill", isOn: $isFilled)
                }
            }
        }
    }
}

#Preview {
    SettingView(zoomLevel: .constant(1), baseSize: .constant(10), baseSpacing: .constant(10), shape: .constant(.circle), isFilled: .constant(true))
}
