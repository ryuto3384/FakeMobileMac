//
//  HomeView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var selectedTab: String
    
    private let gridItem: [GridItem] = Array(repeating: .init(.flexible(), spacing: 5), count: 2)
    private let imageWidth: CGFloat = (UIScreen.main.bounds.width / 2.3) - 1
    private let imageHeight: CGFloat = (UIScreen.main.bounds.width / 2.2) - 1
    private let bigImage: CGFloat = (UIScreen.main.bounds.width / 1.1) - 1
    
    var body: some View {
        VStack {
            //ツールバー
            HStack {
                
                VStack{
                    Image(systemName: "person")
                        .font(.system(size: 35))
                    Text("アカウント")
                        .font(.caption)
                }
                .frame(width: 70)
                .foregroundColor(.gray.opacity(0.9))
                
                Spacer()
                
                Image(systemName: "book")
                    .font(.system(size: 50))
                    .foregroundStyle(.yellow)
                
                Spacer()
                
                Text("")
                    .frame(width: 70)
            }
            
            NavigationStack {
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridItem, spacing: 10) {
                        
                        HomeCellViewA(item: "mobileOrder", tab: "order", selectedTab: $selectedTab)
                        
                        HomeCellViewA(item: "delivery" , tab: "delivery",selectedTab: $selectedTab)
                        
                        
                    }
                    
                    
                    HomeCellViewB(item: "デカチラシ")
                        .padding(.top, 8)
                    
                    VStack {
                        HStack {
                            Text("おすすめメニュー")
                            Spacer()
                        }
                        .padding(10)
                        
                        LazyVGrid(columns: gridItem, spacing: 10) {
                            ForEach(0...2, id: \.self) { i in
                                
                                HomeCellVIewC(item: "\(i)")
                                
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("サービス")
                            Spacer()
                        }
                        .padding(10)
                        
                        LazyVGrid(columns: gridItem, spacing: 10) {
                            
                            
                            HomeCellViewD(item: "anketo")
                            
                            HomeCellViewD(item: "search")
                            
                            
                        }
                    }
                    
                    
                    ForEach(0...10, id: \.self) { i in
                        HomeCellViewB(item: "デカチラシ")
                            .padding(.top, 8)
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }//scroll
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        
        
        
    }
}


#Preview {
    ContentView()
}
