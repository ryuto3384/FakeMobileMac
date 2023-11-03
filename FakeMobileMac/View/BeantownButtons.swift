//
//  BeantownButtons.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/11/03.
//

import SwiftUI
import MapKit

struct BeantownButtons: View {
    
    @Binding var position: MapCameraPosition
    
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegioon: MKCoordinateRegion?
    
    var body: some View {
        HStack{
            Button{
                search(for: "マック")
            } label: {
                Label("Macs", systemImage: "figure.and.child.holdinghands")
            }
            .labelStyle(IconOnlyLabelStyle())
            .buttonStyle(.borderedProminent)
            
            Button{
                search(for: "beach")
            } label: {
                Label("Beaches", systemImage: "beach.umbrella")
            }
            .labelStyle(IconOnlyLabelStyle())
            .buttonStyle(.borderedProminent)
            
            Button{
                position = .region(.boston)
            } label: {
                Label("boston", systemImage: "building.2")
            }
            .labelStyle(IconOnlyLabelStyle())
            .buttonStyle(.bordered)
            Button{
                position = .region(.northShore)
            } label: {
                Label("North Shore", systemImage: "water.waves")
            }
            .labelStyle(IconOnlyLabelStyle())
            .buttonStyle(.bordered)
            
        }
    }
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegioon ?? MKCoordinateRegion(
            center: .parking,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        )
        
        Task{
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
    
    
}
#Preview {
    OrderView()
}
