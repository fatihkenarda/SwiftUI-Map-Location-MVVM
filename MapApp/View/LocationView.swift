//
//  LocationView.swift
//  MapApp
//
//  Created by Fatih Kenarda on 14.06.2024.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject private var locationViewModel : LocationViewModel
    
    var body: some View {
        ZStack{
            mapAnnotationLayer
            VStack {
                header
                    .padding()
                Spacer()
                
                ZStack{
                    locationsPreviewStack
                }
            }
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}

extension LocationView {
    
    private var header: some View {
        VStack {
            Button(action: locationViewModel.toggleLocationList){
                Text(locationViewModel.mapLocation.name + " " + locationViewModel.mapLocation.cityName)
                    .frame(maxWidth: .infinity)
                    .fontWeight(.black)
                    .font(.title2)
                    .foregroundColor(Color.primary)
                    .frame(height: 55)
                    .animation(.none, value: locationViewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.primary)
                            .rotationEffect(Angle(degrees: locationViewModel.showLocationList ? 180 : 0))
                    }
            }
            
            if(locationViewModel.showLocationList) {
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20)
    }
    
    private var mapAnnotationLayer: some View {
        Map(coordinateRegion: $locationViewModel.mapRegion,
            annotationItems: locationViewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates){
                LocationMapAnnotationView()
                    .scaleEffect(locationViewModel.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        locationViewModel.showNextLocation(location: location)
                    }
            }
            
        }
        )
    }
    
    private var locationsPreviewStack: some View {
        ForEach(locationViewModel.locations) { location in
            if locationViewModel.mapLocation == location {
                LocationPreviewView(location: location)
                    .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(3.0),
                            radius: 10)
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing),
                                            removal: .move(edge: .leading)))
            }
        }
    }
}
