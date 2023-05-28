//
//  HomePageScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import SwiftUI

struct TabScreen: View {
    @State private var tabSelection = 0
    
    var body: some View {
        TabView {
            Text("The First Tab")
                .tabItem {
                    Image(systemName: "plus.square")
                }
            ReviewScreen()
                .tabItem {
                    Image(systemName: "book")
                }
            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                }
            Text("Calander")
                .tabItem {
                    Image(systemName: "calendar")
                }
            MyPageScreen()
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
        .onAppear {
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
