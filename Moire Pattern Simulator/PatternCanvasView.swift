//Copyright © 2023 MaakCode. All rights reserved.

import SwiftUI

struct PatternCanvasView: View {
    let shape: PatternShape
    let size: CGFloat
    let spacing: CGFloat
    let isFilled: Bool

    init(shape: PatternShape, size: CGFloat, spacing: CGFloat, isFilled: Bool = true) {
        self.shape = shape
        self.size = max(2, size)
        self.spacing = max(0, spacing)
        self.isFilled = isFilled
    }

    var body: some View {
        GeometryReader { geometry in
            Canvas { context, _ in
                let columnCount = Int(ceil(geometry.size.width / size))
                let rowCount = Int(ceil(geometry.size.height / size))

                for row in (0..<rowCount) {
                    for column in (0..<columnCount) {
                        let x = CGFloat(column) * (size + spacing) - geometry.size.width
                        let y = CGFloat(row) * (size + spacing)
                        let path = PatternShapePath(x: x, y: y)
                        if isFilled {
                            context.fill(path, with: .foreground)
                        } else {
                            context.stroke(path, with: .foreground)
                        }
                    }
                }
            }
        }
    }

    private func PatternShapePath(x: CGFloat, y: CGFloat) -> Path {
        let rect = CGRect(x: x, y: y, width: size, height: size)
        switch shape {
        case .circle:
            return Path(ellipseIn: rect)

        case .square:
            return Path(roundedRect: rect, cornerRadius: 0)

        case .triangle:
            var trianglePath = Path()
            trianglePath.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            trianglePath.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            trianglePath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            trianglePath.closeSubpath()
            return trianglePath
        }

    }


    // MARK: - Type

    enum PatternShape {
        case circle, square, triangle
    }
}

#Preview {
    PatternCanvasView(shape: .circle, size: 10, spacing: 10, isFilled: true)
}

#Preview {
    PatternCanvasView(shape: .square, size: 10, spacing: 10, isFilled: false)
}

#Preview {
    PatternCanvasView(shape: .triangle, size: 10, spacing: 10, isFilled: true)
}
