//
//  DiagonalShape.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/19.
//

import Foundation
import SwiftUI

struct DiagonalLine: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        
        return p
    }
}


struct DiagonalLine_Previews: PreviewProvider {
    static var previews: some View {
        DiagonalLine()
            .stroke(Color.red, lineWidth: 1.0)
            .frame(width: 200, height: 200)
    }
}
