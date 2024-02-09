//
//  DeliveryView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI

struct DeliveryView: View {
    
    @State private var isFlag: Bool = true
    
    var body: some View {
        VStack{
            DeliveryHeaderView()
            
            VStack(spacing: 30){
                
                VStack(alignment: .leading) {
                    Text("お届け先を選択してください")
                        .font(.callout)
                    Text("住所は5つまで保存できます")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack{
                    Button{
                        //ここに処理
                    } label: {
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text("新規お届け先を入力")
                        }
                        .font(.callout)
                        .foregroundStyle(.black)
                        .padding()
                        .frame(width: 200, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }.padding(.bottom)
                    
                    
                    
                    Button {
                        
                    } label: {
                        Text("今すぐ注文")
                            .font(.callout)
                            .foregroundStyle(isFlag ? .black : .white)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 6).fill(isFlag ? Color.gray : Color.gray))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding(.bottom)
                    
                    Button {
                        
                    } label: {
                        Text("配達時間を指定して注文")
                            .font(.callout)
                            .underline()
                            .foregroundStyle(.gray)
                    }
                    
                    
                }
                
                VStack (alignment: .leading, spacing: 6) {
                    Text("※デリバリーサービスをご利用の場合、販売価格がメニュー価格と異なります。")
                        .foregroundStyle(.gray)
                    Text("※受付時間は店舗により異なります。")
                        .foregroundStyle(.gray)
                    Text("※1,500円から注文可能です。")
                    Text("※別途デリバリー料300円かかります")
                    Text("※10冊を超える注文は承ることができません。")
                }
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Spacer()
                
            }
            .padding()
        }
    }
}

#Preview {
    DeliveryView()
}
