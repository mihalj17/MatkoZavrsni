//
//  MapView.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 29.04.2024..
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel
    @StateObject var locationManager:LocationManager = .init()
    
    @State var mapRegion: MapCameraPosition = .region(.myRegion)
    @State var showMap:Bool = false
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    
    
    
    var body: some View {

        VStack{
            if showMap{
                Map(position: $mapRegion, selection: $mapSelection){
                    Marker("Matko", systemImage: "person.fill",coordinate: CLLocationCoordinate2D(latitude: locationManager.userLocation.latitude, longitude: locationManager.userLocation.longitude))
                    
                    ForEach(viewModel.sightsInDjakovo, id: \.self) {item in
                        let placemark = item.placemark
                        Marker(placemark.name ?? "",coordinate: placemark.coordinate)
                    }
                    
                    
                }
                
                .onAppear(perform: {
                    mapRegion = .region(MKCoordinateRegion(center: locationManager.userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000))
                })
                
                
                
            }
            else {
                ProgressView()
                    .progressViewStyle(.circular)
                Text("Fetching your location")
            }
        }
        .onChange(of: mapSelection, {oldValue, newValue in
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            
            DetailsView(mapSelection: $mapSelection, show:$showDetails)
                .presentationDetents([.height(460)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
            
            
        })
        .onChange(of: locationManager.isLocationAuthorized) { oldValue, newValue in
            if newValue {
                showMap = true
            }
        }
        .onAppear{
            viewModel.fetchSightsDataFromDatabase()
        }
    }
}
#Preview {
    MapView(viewModel: .init(DataBaseService: DataBaseService()))
}
