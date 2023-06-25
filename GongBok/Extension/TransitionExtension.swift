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
    var pos: CGPoint
    
    func body(content: Content) -> some View {
        content.offset(x: pos.x, y: pos.y)
    }
}

extension AnyTransition {
    enum State {
        case insertion, removal
    }
}

extension AnyTransition {
    static func openSildeEffect() -> AnyTransition {
        return .modifier(active: HorizontalScaleShape(percent: 0.0), identity: HorizontalScaleShape(percent: 1.0))
    }

}


// MARK: - 커스텀 슬라이드
extension AnyTransition {
    static func customSlide(from: CGPoint, to: CGPoint, state: State) -> AnyTransition {
        if state == .insertion {
            return .modifier(active: OffsetedShape(pos: from), identity: OffsetedShape(pos: to))
        }
        return .modifier(active: OffsetedShape(pos: to), identity: OffsetedShape(pos: from))
    }
    
}


