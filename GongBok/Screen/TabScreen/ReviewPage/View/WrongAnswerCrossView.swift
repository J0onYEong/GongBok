//
//  DiagonalShape.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/19.
//

import Foundation
import SwiftUI

fileprivate struct DiagonalLine: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        
        return p
    }
}


struct WrongAnswerCrossView: View {
    @State private var isShowing = true
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            ZStack {
                Rectangle()
                    .fill(.clear)
                DiagonalLine()
                    .stroke(Color.red, lineWidth: 1.0)
                    .offset(isShowing ? CGSize(width: 200, height: -200) : CGSize(width: 0, height: 0))
                .zIndex(1)
                    
            }
            .frame(width: width, height: height)
            .position(CGPoint(x: width/2, y: height/2))
            .clipShape(Rectangle())
        }
        .aspectRatio(contentMode: .fit)
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                isShowing = false
            }
        }
    }
}


struct DiagonalLine_Previews: PreviewProvider {
    static var previews: some View {
        WrongAnswerCrossView()
            .frame(width: 200, height: 200)
    }
}
