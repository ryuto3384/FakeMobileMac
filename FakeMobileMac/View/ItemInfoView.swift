//
//  ItemInfoView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/11/03.
//

import SwiftUI
import MapKit

struct ItemInfoView: View {
    
    @State private var lookAroundScene: MKLookAroundScene?
    
    var selectedResult: MKMapItem?
    var route: MKRoute?
    
    func getLookAroundScene() {
        guard let selectedResult else { return }
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: selectedResult)
            lookAroundScene = try? await request.scene
        }
    }
    
    var body: some View{
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                
                HStack {
                    if let selectedResult {
                        Text("\(selectedResult.name ?? "")")
                        if let travelTime{
                            Text(travelTime)
                        }
                    }
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
            }
            .onAppear{
                getLookAroundScene()
            }
            .onChange(of: selectedResult) {
                getLookAroundScene()
            }
    }
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
}
