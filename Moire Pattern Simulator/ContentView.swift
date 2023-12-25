//Copyright © 2023 MaakCode. All rights reserved.

import SwiftUI

struct ContentView: View {
    @State var zoomLevel: CGFloat = 0.5
    @State var baseSize: CGFloat = 5
    @State var baseSpacing: CGFloat = 5
    @State var angle: Angle = .zero
    @State var shape: PatternCanvasView.PatternShape = .circle
    @State var isFilled: Bool = true

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
                    .scaleEffect(.init(width: 0.94, height: 0.94))
                    .rotationEffect(angle + rotation, anchor: .center)
                    .offset(x: offset.width + translation.width - 1000 + geometry.size.width / 2, y: offset.height + translation.height - 1000 + geometry.size.height / 2)
            }
            .gesture(dragGesture)
            .gesture(rotationGesture)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
