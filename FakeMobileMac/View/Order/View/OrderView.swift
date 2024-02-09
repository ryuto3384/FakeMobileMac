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

extension MKMapRect {
    func reducedRect(_ fraction: CGFloat = 0.35) -> MKMapRect {
        var regionRect = self

        let wPadding = regionRect.size.width * fraction
        let hPadding = regionRect.size.height * fraction
                    
        regionRect.size.width += wPadding
        regionRect.size.height += hPadding
                    
        regionRect.origin.x -= wPadding / 2
        regionRect.origin.y -= hPadding / 2
        
        return regionRect
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
    
    @State private var showDetails: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?
   
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    var body: some View {
        
        NavigationStack {
            Map(position: $position, selection: $selectedResult, scope: locationSpace) {
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
                    if routeDisplaying {
                        if result == routeDestination {
                            let placemark = result.placemark
                            Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                                .tint(.blue)
                        }
                    } else {
                        let placemark = result.placemark
                        Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                            .tint(.blue)
                    }
                    
                }
                .annotationTitles(.hidden)
                
                if let route {
                    MapPolyline(route.polyline)
                    /// Applying Bigger Stroke
                        .stroke(.blue, lineWidth: 7)
                }

                
                UserAnnotation()
                
            }
            .onMapCameraChange({ ctx in
                viewingRegion = ctx.region
            })
            .mapStyle(.standard(elevation: .realistic))
            
            //現在地などのボタン
            .overlay(alignment: .bottomTrailing) {
                VStack(spacing: 15) {
                    MapUserLocationButton(scope: locationSpace)
                    MapPitchToggle(scope: locationSpace)
                    Button {
                        withAnimation(.smooth) {
                            position = .region(.myRegion)
                        }
                    } label: {
                        Image(systemName: "mappin")
                            .font(.title3)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .buttonBorderShape(.circle)
                .padding()
            }
            .mapScope(locationSpace)
            .navigationTitle("モバイルオーダー")
            .navigationBarTitleDisplayMode(.inline)
            
            //searchbar
            .searchable(text: $searchText, isPresented: $showSearch)
            
            //toolbarのデザイン
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            
            .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
            .sheet(isPresented: $showDetails, onDismiss: {
                withAnimation(.snappy) {
                    if let boundingRect = route?.polyline.boundingMapRect, routeDisplaying {
                        position = .rect(boundingRect.reducedRect(0.45))
                    }
                }
            }, content: {
                MapDetails()
                    .presentationDetents([.height(300)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                    .presentationCornerRadius(25)
                    .interactiveDismissDisabled(true)
            })
            .safeAreaInset(edge: .bottom) {
                if routeDisplaying {
                    Button("End Route") {
                        withAnimation(.snappy) {
                            routeDisplaying = false
                            showDetails = true
                            selectedResult = routeDestination
                            routeDestination = nil
                            route = nil
                            if let coordinate = selectedResult?.placemark.coordinate {
                                position = .region(.init(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000))
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .padding(.vertical, 12)
                    .background(.red.gradient, in: .rect(cornerRadius: 15))
                    .padding()
                    .background(.ultraThinMaterial)
                }
            }
        }
        //検索結果を送信&取得
        .onSubmit(of: .search) {
            //Task内は非同期処理を行える
            Task {
                guard !searchText.isEmpty else {return}
                await searchPlaces()
            }
        }
        
        .onChange(of: showSearch, initial: false) {
            if !showSearch {
                searchResults.removeAll(keepingCapacity: false)
                showDetails = false
                withAnimation(.smooth) {
                    position = .region(viewingRegion ?? .myRegion)
                }
            }
        }
        
        .onChange(of: selectedResult) { oldValue, newValue in
            showDetails = newValue != nil
            fetchLookAroundPreview()
        }
        
        //アプリ起動時に位置情報の許可
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
        }
        
        
        
    }
    @ViewBuilder
    func MapDetails() -> some View {
        VStack(spacing: 15) {
            ZStack {
                if lookAroundScene == nil {
                    /// New Empty View API
                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
                } else {
                    LookAroundPreview(scene: $lookAroundScene)
                }
            }
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 15))
            /// Close Button
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showDetails = false
                    withAnimation(.snappy) {
                        selectedResult = nil
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                        .background(.white, in: .circle)
                })
                .padding(10)
            }
            
            /// Direction's Button
            Button("Get Directions", action: fetchRoute)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
                .background(.blue.gradient, in: .rect(cornerRadius: 15))
        }
        .padding(15)
    }
    
    
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .myRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    
    func fetchLookAroundPreview() {
        if let selectedResult {
            /// Clearing Old One
            lookAroundScene = nil
            Task.detached(priority: .background) {
                let request = MKLookAroundSceneRequest(mapItem: selectedResult)
                lookAroundScene = try? await request.scene
            }
        }
    }
    
    func fetchRoute() {
        if let selectedResult {
            let request = MKDirections.Request()
            request.source = .init(placemark: .init(coordinate: .myLocation))
            request.destination = selectedResult
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                /// Saving Route Destination
                routeDestination = selectedResult
                
                withAnimation(.snappy) {
                    routeDisplaying = true
                    showDetails = false
                }
            }
        }
    }
    
}


#Preview {
    OrderView()
}
