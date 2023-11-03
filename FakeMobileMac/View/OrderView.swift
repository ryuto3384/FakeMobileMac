//
//  OrderView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 35.264406848968754, longitude: 137.04344647983666)
}

extension MKCoordinateRegion {
    static let boston = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.360256, longitude: -71.057279
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1, longitudeDelta: 0.1
        )
    )
    static let northShore = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.547408, longitude: -70.870085
        ),
        //領域？
        span: MKCoordinateSpan(
            latitudeDelta: 0.5, longitudeDelta: 0.5
        )
    )
}

struct OrderView: View {
    
    @State private var searchResults: [MKMapItem] = []
    
    @State private var visibleRegion: MKCoordinateRegion?
    
    @State private var position: MapCameraPosition = .automatic
    
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    
    var body: some View {
        
        Map(position: $position, selection: $selectedResult){
            Annotation("Station", coordinate: .parking) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 5)
                    Image(systemName: "train.side.rear.car")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)
            
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
            .annotationTitles(.hidden)
            
            UserAnnotation()
            
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack{
                Spacer()
                VStack(spacing: 0){
                    
                    
                    BeantownButtons(position: $position, searchResults: $searchResults, visibleRegioon: visibleRegion)
                        .padding(.top)
                }
                Spacer()
                
            }
            .background(.thinMaterial)
        }
        .onChange(of: searchResults) {
            position = .automatic
        }
        .onChange(of: selectedResult) {
            getDirections()
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        //現在地ボタン
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        
        
    }
    
    func getDirections() {
        route = nil
        guard let selectedResult else { return }
        
        let request = MKDirections.Request()
        request.source  = MKMapItem(placemark: MKPlacemark(coordinate: .parking))
        request.destination = selectedResult
        
        Task{
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            
            route = response?.routes.first
        }
    }
    
    
}


#Preview {
    OrderView()
}
