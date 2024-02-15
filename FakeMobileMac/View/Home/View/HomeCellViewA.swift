//
//  HomeCellViewA.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2024/02/15.
//

import SwiftUI

struct HomeCellViewA: View {
    let item: String
    let tab: String
    @Binding var selectedTab: String
    
    private let imageWidth: CGFloat = (UIScreen.main.bounds.width / 2.3) - 1
    private let imageHeight: CGFloat = (UIScreen.main.bounds.width / 2.2) - 1
    
    var body: some View {
        Button{
            if !tab.isEmpty {
                self.selectedTab = tab
            } else {
                print("押された")
            }
        } label: {
            Image(item)
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)
        }
    
    }
}

