//
//  SpeechBubbleviewModel.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/04.
//

import Foundation


class SpeechBuubleViewModel: ObservableObject {
    @Published var bubbleText = ""
    
    let bubbleData = [
        "오늘도 열심히 해보자!",
        "얼른 복습하자!",
        "복습! 복습! 복습!"
    ]
    
    func startBubbleText() {
        objectWillChange.send()
        bubbleText = bubbleData.randomElement()!
        
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [unowned self] _ in
            self.objectWillChange.send()
            let element = self.bubbleData.randomElement()!
            if element == self.bubbleText {
                self.bubbleText = self.bubbleData.first(where: { str in
                    return str != self.bubbleText
                })!
            } else {
                self.bubbleText = element
            }
        }
    }
    
}
