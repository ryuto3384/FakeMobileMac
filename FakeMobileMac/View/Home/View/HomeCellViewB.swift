//
//  HomeCellViewB.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2024/02/15.
//

import SwiftUI

struct HomeCellViewB: View {
    
    let item: String
    
    private let bigImage: CGFloat = (UIScreen.main.bounds.width / 1.1) - 1
    
    var body: some View {
        Text("デカチラシ")
            .frame(width: bigImage, height: bigImage)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 2)
    }
}

#Preview {
    HomeCellViewB(item: "デカチラシ")
}
