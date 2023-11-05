//
//  OrderView.swift
//  FakeMobileMac
//
//  Created by 中島瑠斗 on 2023/09/29.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let myLocation = CLLocationCoordinate2D(latitude: 35.264406848968754, longitude: 137.04344647983666)
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}

struct OrderView: View {
    
    @State private var position: MapCameraPosition = .region(.myRegion)
    @State private var selectedResult: MKMapItem?
    //buttonのアニメーションを追加するもの
    //押されると選択されてる感じが出る
    @Namespace private var locationSpace
    @State private var viewingRegion: MKCoordinateRegion?
    
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    
    @State private var showDetaiols: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?
   
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    var body: some View {
        
        NavigationStack {
            Map(position: $position, selection: $selectedResult, selection: $selectedResult){
                Annotation("Station", coordinate: .myLocation) {
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
                    let placemark = result.placemark
                    Marker(placemark.name ?? "place", coordinate: placemark.coordinate)
                    
                }
                .annotationTitles(.hidden)
                
                UserAnnotation()
                
            }
            .mapStyle(.standard(elevation: .realistic))
            
            //現在地などのボタン
            .overlay(alignment: .bottomTrailing) {
                VStack(spacing: 15) {
                    MapUserLocationButton(scope: locationSpace)
                    MapCompass(scope: locationSpace)
                    MapPitchToggle(scope: locationSpace)
                }
            }
            .mapScope(locationSpace)
            .navigationTitle("モバイルオーダー")
            .navigationBarTitleDisplayMode(.inline)
            
            //searchbar
            .searchable(text: $searchText, isPresented: $showSearch)
            
            //toolbarのデザイン
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
        //検索結果を送信&取得
        .onSubmit {
            //Task内は非同期処理を行える
            Task {
                guard !searchText.isEmpty else {return}
                await searchPlaces()
            }
        }
        
        //アプリ起動時に位置情報の許可
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
        }
        
        
        
    }
    
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .myRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    
}


#Preview {
    OrderView()
}
