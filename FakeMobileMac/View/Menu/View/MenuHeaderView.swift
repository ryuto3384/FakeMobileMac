//
//  MenuHeaderView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2024/02/09.
//

import SwiftUI

struct MenuHeaderView: View {
    
    let categories = ["新書", "漫画", "小説", "ラノベ", "ビジネス・経済", "コンピュータ・IT", "社会・政治", "雑誌", "お金", "趣味", "歴史"]
    
    @Binding var selectedCategory: String?
    
    var body: some View {
        VStack(spacing: 15) {
            
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
            
            //カテゴリー一覧
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(categories, id: \.self) { category in
                            VStack(spacing: 5) {
                                if selectedCategory == category {
                                    Text(category)
                                        .font(.callout)
                                        .padding(.horizontal, 5)
                                    
                                        .foregroundColor(.red)
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.red)
                                } else {
                                    Text(category)
                                        .font(.callout)
                                        .padding(.horizontal, 5)
                                        .foregroundColor(.black)
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.clear)
                                }
                            }
                            //id付けでうまく動作する
                            .id(category)
                            .onTapGesture {
                                withAnimation {
                                    self.selectedCategory = category
                                    value.scrollTo(category, anchor: .center)
                                }
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    
                }
                .frame(height: 25)
                .onChange(of: selectedCategory) {
                    withAnimation {
                        value.scrollTo(selectedCategory, anchor: .center)
                    }
                }
                
                
                
            }
            
        }//Vstack
        .padding(.horizontal)
    }
}

#Preview {
    MenuView()
}
