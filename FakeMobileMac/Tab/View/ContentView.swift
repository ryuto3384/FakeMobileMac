//
//  ContentView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = "home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("ホーム", systemImage: "house")
                }
                .tag("home")
            
            CouponView()
                .tabItem {
                    Label("クーポン", systemImage: "ticket")
                }
                .tag("coupon")
            
            MenuView()
                .tabItem {
                    Label("メニュー", systemImage: "apple.logo")
                }
                .tag("menu")
            
            DeliveryView()
                .tabItem {
                    Label("デリバリー", systemImage: "bicycle")
                }
                .tag("delivery")
            
            OrderView()
                .tabItem {
                    Label("オーダー", systemImage: "iphone.gen1.radiowaves.left.and.right")
                }
                .tag("order")
        }
    }
}

#Preview {
    ContentView()
}
