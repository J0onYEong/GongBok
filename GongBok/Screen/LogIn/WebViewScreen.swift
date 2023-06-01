//
//  WebViewScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/31.
//

import SwiftUI

struct WebViewScreen: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            WebViewRepresentable(url: URL(string: APIUrl.kakaoLoginWeb)!)
        }
    }
}

struct WebViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        WebViewScreen()
    }
}
