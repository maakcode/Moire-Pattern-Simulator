//Copyright © 2023 MaakCode. All rights reserved.

import SwiftUI

struct ContentView: View {
    @State var isBottomsheetVisible: Bool = false
    @State var zoomLevel: CGFloat = 0.5
    @State var baseSize: CGFloat = 5
    @State var baseSpacing: CGFloat = 5
    @State var shape: PatternCanvasView.PatternShape = .circle
    @State var isFilled: Bool = true

    @State var angle: Angle = .zero
    @GestureState var rotation: Angle = .zero
    @State var offset: CGSize = .zero
    @GestureState var translation: CGSize = .zero

    var dragGesture: some Gesture {
        DragGesture()
            .updating($translation) { value, state, _ in
                state = value.translation
            }
            .onEnded{ value in
                offset.width += value.translation.width
                offset.height += value.translation.height
            }
    }
    var rotationGesture: some Gesture {
        RotationGesture()
            .updating($rotation) { value, state, _ in
                state = Angle(radians: value.radians)
            }
            .onEnded { value in
                angle += Angle(radians: value.radians)
            }

    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                PatternCanvasView(shape: shape, size: baseSize, spacing: baseSpacing, isFilled: isFilled)
                PatternCanvasView(shape: shape, size: baseSize, spacing: baseSpacing, isFilled: isFilled)
                    .frame(width: 2000, height: 2000, alignment: .center)
                    .scaleEffect(.init(width: zoomLevel, height: zoomLevel))
                    .rotationEffect(angle + rotation, anchor: .center)
                    .offset(x: offset.width + translation.width - 1000 + geometry.size.width / 2, y: offset.height + translation.height - 1000 + geometry.size.height / 2)
            }
            .gesture(dragGesture)
            .gesture(rotationGesture)
            .onTapGesture {
                isBottomsheetVisible = true
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isBottomsheetVisible) {
            SettingView(zoomLevel: $zoomLevel, baseSize: $baseSize, baseSpacing: $baseSpacing, shape: $shape, isFilled: $isFilled)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    ContentView()
}
