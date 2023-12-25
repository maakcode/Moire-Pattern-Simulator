//Copyright © 2023 MaakCode. All rights reserved.

import SwiftUI

struct PatternCanvasView: View {
    let size: CGFloat
    let spacing: CGFloat

    init(size: CGFloat, spacing: CGFloat) {
        self.size = max(2, size)
        self.spacing = max(0, spacing)
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

                        let rect = CGRect(x: x, y: y, width: size, height: size)

                        let path = Path(ellipseIn: rect)
                        context.fill(path, with: .foreground)
                    }
                }
            }
        }
    }
}

#Preview {
    PatternCanvasView(size: 10, spacing: 10)
}
