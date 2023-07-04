//
//  HomePageScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import SwiftUI

struct TabScreen: View {
    @State private var tabSelection = 3
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ReviewScreen()
                .tabItem {
                    Image(systemName: "book")
                }
                .tag(2)
            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(3)
            MyPageScreen()
                .tabItem {
                    Image(systemName: "gearshape")
                }
                .tag(5)
        }
        .onAppear {
            UITabBar.appearance().shadowImage = UIImage()
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().isTranslucent = true
            UITabBar.appearance().backgroundColor = UIColor(hex: "D7CCBD")!
        }
        .accentColor(.tabViewAccent)
    }
}

struct HomePageScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabScreen()
    }
}
