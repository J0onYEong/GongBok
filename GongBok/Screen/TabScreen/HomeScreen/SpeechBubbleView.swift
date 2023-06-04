//
//  SpeechBubbleView.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/03.
//

import SwiftUI

struct BezierCurveShape: Shape, InsettableShape {
    var insetAmount = 0.0
    
    var pointInset = 0.94
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var startPoint = CGPoint(x: rect.midX, y: rect.minY+insetAmount)
        var endPoint = CGPoint(x: rect.maxX-insetAmount, y: rect.midY)
        var controlPoint1 = CGPoint(x: rect.maxX-insetAmount, y: rect.minY+insetAmount)
        var controlPoint2 = CGPoint(x: rect.maxX-insetAmount, y: rect.midY)
        
        path.move(to: startPoint)
        path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        
        startPoint = CGPoint(x: rect.maxX-insetAmount, y: rect.midY)
        endPoint = CGPoint(x: rect.midX*(7/4), y: rect.midY*(3/2))
        controlPoint1 = CGPoint(x: rect.maxX-insetAmount, y: rect.midY*(3/2))
        controlPoint2 = CGPoint(x: rect.midX*(7/4), y: rect.midY*(3/2))
    
        path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)

        path.addLine(to: CGPoint(x: (rect.maxX-insetAmount)*pointInset, y: (rect.maxY-insetAmount)*pointInset))

        startPoint = CGPoint(x: rect.midX*(3/2), y: rect.midY*(7/4))
        endPoint = CGPoint(x: rect.midX, y: rect.maxY-insetAmount)
        controlPoint1 = CGPoint(x: rect.midX*(3/2), y: rect.maxY-insetAmount)
        controlPoint2 = CGPoint(x: rect.midX, y: rect.maxY-insetAmount)

        path.addLine(to: startPoint)
        path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        
        startPoint = CGPoint(x: rect.midX, y: rect.maxY-insetAmount)
        endPoint = CGPoint(x: rect.minX+insetAmount, y: rect.midY)
        controlPoint1 = CGPoint(x: rect.minX+insetAmount, y: rect.maxY-insetAmount)
        controlPoint2 = CGPoint(x: rect.minX+insetAmount, y: rect.midY)
        
        path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        
        startPoint = CGPoint(x: rect.minX+insetAmount, y: rect.midY)
        endPoint = CGPoint(x: rect.midX, y: rect.minY+insetAmount)
        controlPoint1 = CGPoint(x: rect.minX, y: rect.minY+insetAmount)
        controlPoint2 = CGPoint(x: rect.midX, y: rect.minY+insetAmount)
        
        path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        
        path.closeSubpath()
        
        return path
    }
}
struct SpeechBubbleView: View {
    
    @ObservedObject private var viewModel = SpeechBuubleViewModel()
    
    var body: some View {
        Text(viewModel.bubbleText)
            .font(Font.system(size: 14))
            .frame(height: 14)
            .padding(.horizontal, 10)
            .background(
                BezierCurveShape()
                    .strokeBorder(.black, lineWidth: 1.5)
                    .aspectRatio(1.5, contentMode: .fill)
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: viewModel.bubbleText)
            .onAppear {
                viewModel.startBubbleText()
            }
            .onDisappear {
                viewModel.stopBubbleText()
            }
    }
}

struct SpeechBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechBubbleView()
    }
}
