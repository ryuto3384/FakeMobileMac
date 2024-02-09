//
//  DeliveryHeaderView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2024/02/09.
//

import SwiftUI

struct DeliveryHeaderView: View {
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Text("配達情報を入力")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            Divider()
        }
    }
}

#Preview {
    DeliveryView()
}
