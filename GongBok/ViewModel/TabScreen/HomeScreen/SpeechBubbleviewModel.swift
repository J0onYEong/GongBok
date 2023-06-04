//
//  SpeechBubbleviewModel.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/04.
//

import Foundation


class SpeechBuubleViewModel: ObservableObject {
    @Published private(set) var bubbleText = ""
    
    lazy var timer = Timer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    
    init() {
        _bubbleText = Published(initialValue: bubbleData.randomElement()!)
    }
    
    private let bubbleData = [
        "오늘도 열심히 해보자!",
        "얼른 복습하자!",
        "복습! 복습! 복습!"
    ]
    
    func startBubbleText() {
        RunLoop.main.add(timer, forMode: .common)
    }
    
    func stopBubbleText() {
        timer.invalidate()
    }
    
    @objc
    func timerAction() {
        objectWillChange.send()
        let element = bubbleData.randomElement()!
        if element == bubbleText {
            bubbleText = bubbleData.first(where: { str in
                return str != bubbleText
            })!
        } else {
            bubbleText = element
        }
    }
}
