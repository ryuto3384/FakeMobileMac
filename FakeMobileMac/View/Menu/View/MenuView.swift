//
//  MenuView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI

struct MenuView: View {
    
    let categories = ["新書", "漫画", "小説", "ラノベ", "ビジネス・経済", "コンピュータ・IT", "社会・政治", "雑誌", "お金", "趣味", "歴史"]
    
    private let gridItem: [GridItem] = Array(repeating: .init(.flexible(), spacing: 5), count: 2)
    
    private let imageWidth: CGFloat = (UIScreen.main.bounds.width / 2.3) - 1
    private let imageHeight: CGFloat = (UIScreen.main.bounds.width / 2.2) - 1
    
    @State private var selectedCategory: String?
    
    init() {
        _selectedCategory = State(initialValue: categories.first)
    }
    
    var body: some View {
        VStack{
            VStack{
                MenuHeaderView(selectedCategory: $selectedCategory)
                Divider()
            }
            
            if let selCate = selectedCategory {
                
                //フィルターを配列に掛ける
                
                
                GeometryReader { geometry in
                    ScrollViewReader { value in
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            LazyHStack(spacing: 0) {
                                
                                ForEach(categories, id: \.self) { category in
                                    
                                    VStack{
                                        
                                        Text("\(category)")
                                        
                                        ScrollView(showsIndicators: false) {
                                            LazyVGrid(columns: gridItem, spacing: 10) {
                                                ForEach(0...20, id: \.self) { i in
                                                    
                                                    Text("\(i)")
                                                        .frame(width: imageWidth, height: imageHeight)
                                                    
                                                        .background(Color.gray)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        .shadow(radius: 2)
                                                    
                                                }
                                            }
                                            .frame(minHeight: geometry.size.height)
                                            
                                            
                                            Text(selCate)
                                                .padding(.top)
                                        }
                                        .frame(width: geometry.size.width)
                                    }
                                    
                                    
                                }
                                
                            }
                            .scrollTargetLayout()
                            
                            
                        }
                        //上のscrollTargetLayout()でターゲットとした部分からスクロールをどのようにするかを指定することができる
                        //pagingは,ticktokなどのようなスクロール画面を実現できる
                        //viewAlignedはスクロール位置を細かく指定できる
                        //またこのとき、LazyStackのspacingは0で設定することがコツ
                        .scrollTargetBehavior(.paging)
                        .scrollPosition(id: $selectedCategory)
                        
                        
                    }
                    
                    
                    
                }
                .padding(.horizontal)
            }
                
        }
    }
    
}

#Preview {
    MenuView()
}
