//
//  HomeView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI

struct HomeView: View {
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
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
    HomeView()
}
