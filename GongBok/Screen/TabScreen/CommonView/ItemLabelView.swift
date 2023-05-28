//
//  ItemLabel.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/20.
//

import SwiftUI

enum LabelTextAlignment {
    case leading, center
}


struct ItemLabelView: View {
    var color: Color
    var text: String
    
    var image: Image = Image(systemName: "chevron.right")
    var showImage = true
    
    var alignment: LabelTextAlignment = .center
    
    var body: some View {
        ZStack {
            HStack {
                if alignment == .center {
                    Spacer()
                }
                Text(text)
                    .font(Font.system(size: 15, weight: .semibold))
                    .frame(height: 15)
                Spacer()
            }
            .padding([.vertical], 20)
            .padding(.leading, alignment == .center ? 0 : 30)
            if showImage {
                HStack {
                    Spacer()
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                        .padding(.trailing, 20)
                }
            }
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(color)
                    .shadow(color: .gray, radius: 3, y: 2)
                    .padding(3)
            }
            
        )
    }
}

struct ItemLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ItemLabelView(color: .white, text: "1차시")
            .frame(height: 60)
            .padding([.horizontal], 20)
    }
}
