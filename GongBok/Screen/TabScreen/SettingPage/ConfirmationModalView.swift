//
//  ConfirmationModalView.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct ConfirmationModalView: View {
    
    @Binding var isPresent: Bool
    
    var mainText: String
    
    var onAccept: (() -> ())?
    
    var onRefuse: (() -> ())?
    
    var body: some View {
        if isPresent {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .ignoresSafeArea()
        }
        
        if isPresent {
            VStack {
                Text(mainText)
                    .font(Font.system(size: 20, weight: .bold))
                    .padding(.bottom, 40)
                
                
                HStack {
                    Spacer()
                    Button {
                        
                        onAccept?()
                        
                    } label: {
                        Text("예")
                            .frame(width: 50, height: 17)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 18.5)
                                    .foregroundColor(.refuse)
                                    .shadow(color: .gray, radius: 1.5, y: 1.5)
                            )
                    }
                    .foregroundColor(.white)
                    Spacer()
                    Button {
                        onRefuse?()
                        
                        withAnimation {
                            isPresent = false
                        }
                    } label: {
                        Text("아니요")
                            .frame(width: 50, height: 17)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 18.5)
                                    .foregroundColor(.accept)
                                    .shadow(color: .gray, radius: 1.5, y: 1.5)
                            )
                    }
                    .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(.vertical, 60)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
            )
            .padding(.horizontal, 20)
        }
    }
}
