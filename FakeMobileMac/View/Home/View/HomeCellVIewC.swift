//
//  HomeCellVIewC.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2024/02/15.
//

import SwiftUI

struct HomeCellVIewC: View {
    
    let item: String
    
    private let imageWidth: CGFloat = (UIScreen.main.bounds.width / 2.3) - 1
    private let imageHeight: CGFloat = (UIScreen.main.bounds.width / 2.2) - 1
    
    var body: some View {
        VStack{
            Spacer()
            Text("\(item)")
            Spacer()
            HStack {
                Text("値段")
                Spacer()
                Button {
                    print("追加")
                } label: {
                    HStack{
                        Image(systemName: "cart.badge.plus")
                        Text("追加")
                    }
                    .frame(width: 80, height: 25)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal, 3)
            .padding(.bottom, 3)
                
        }
        .frame(width: imageWidth, height: imageHeight)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
        
    }
}

#Preview {
    HomeCellVIewC(item: "ポテト")
}
