//
//  ContentView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("ホーム", systemImage: "house")
                }
            
            CouponView()
                .tabItem {
                    Label("クーポン", systemImage: "ticket")
                }
            
            MenuView()
                .tabItem {
                    Label("メニュー", systemImage: "apple.logo")
                }
            
            DeliveryView()
                .tabItem {
                    Label("デリバリー", systemImage: "bicycle")
                }
            
            OrderView()
                .tabItem {
                    Label("オーダー", systemImage: "iphone.gen1.radiowaves.left.and.right")
                }
        }
    }
}

#Preview {
    ContentView()
}
