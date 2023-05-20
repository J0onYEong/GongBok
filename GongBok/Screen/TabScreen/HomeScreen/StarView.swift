//
//  StarView.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/16.
//

import SwiftUI

struct StarView: View {
    var starCount: Int
    
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ZStack {
                    Image("star1")
                        .resizable()
                        .scaledToFit()
                        .position(x: geo.size.width/2, y: geo.size.height/2)
                    Text(starCount > 999 ? "999+" : String(starCount))
                        .font(Font.system(size: geo.size.height/6, weight: .bold))
                        .foregroundColor(.white)
                        .frame(height: geo.size.height/6)
                        .padding([.horizontal], 4)
                        .padding([.vertical], 2.5)
                        .background(
                            RoundedRectangle(cornerRadius: geo.size.height/8)
                                .fill(.refuse)
                        )
                        .position(x: geo.size.width/5, y: geo.size.height/5)
                }
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView(starCount: 1000)
//            .frame(width: 70, height: 70)
    }
}
