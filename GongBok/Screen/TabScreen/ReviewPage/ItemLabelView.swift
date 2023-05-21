//
//  ItemLabel.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/20.
//

import SwiftUI

struct ItemLabelView: View {
    var color: Color
    var text: String
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Spacer()
                Text(text)
                    .font(Font.system(size: geo.size.height/4, weight: .semibold))
                    .frame(height: geo.size.height/4)
                    .padding([.vertical], geo.size.height/3)
                Spacer()
            }
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: geo.size.height/2)
                        .fill(color)
                        .shadow(color: .gray, radius: 3, y: 2)
                        .padding(3)
                }
                
            )
            .position(x: geo.size.width/2, y: geo.size.height/2)
        }
    }
}

struct ItemLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ItemLabelView(color: .white, text: "1차시")
            .frame(height: 60)
            .padding([.horizontal], 20)
    }
}
