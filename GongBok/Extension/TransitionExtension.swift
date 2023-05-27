//
//  TransitionExtension.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/27.
//

import SwiftUI

struct HorizontalScaleShape: ViewModifier {
    var percent: CGFloat
    
    func body(content: Content) -> some View {
        content.scaleEffect(x: percent, y: 1.0)
    }
}

struct OffsetedShape: ViewModifier {
    var pos: CGSize
    
    func body(content: Content) -> some View {
        content.offset(pos)
    }
}

extension AnyTransition {
    
    static func openSildeEffect() -> AnyTransition {
        return .modifier(active: HorizontalScaleShape(percent: 0.0), identity: HorizontalScaleShape(percent: 1.0))
    }
    
    static func customSlideEffect(pos: CGSize) -> AnyTransition {
        return .modifier(active: OffsetedShape(pos: pos), identity: OffsetedShape(pos: CGSize(width: 0, height: 0)))
    }
}
