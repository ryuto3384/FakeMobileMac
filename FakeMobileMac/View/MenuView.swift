//
//  MenuView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        //action
                    } label: {
                        VStack{
                            Image(systemName: "rectangle.on.rectangle.square")
                                .font(.title)
                            Text("ポイント")
                                .font(.caption)
                        }
                        .foregroundColor(.gray.opacity(0.9))
                        .padding(10)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        //action
                    } label: {
                        VStack{
                            Image(systemName: "person")
                                .font(.title)
                            Text("アカウント")
                                .font(.caption)
                        }
                        .foregroundColor(.gray.opacity(0.9))
                        .padding(10)
                    }
                }
            }
        }
        
    }
}

#Preview {
    MenuView()
}
