//
//  LocationViewModel.swift
//  MapApp
//
//  Created by Fatih Kenarda on 14.06.2024.
//

import Foundation
import SwiftUI
import MapKit

class LocationViewModel: ObservableObject {
    
    //Bütün konumlar yüklenir
    @Published var locations : [Location]
    
    //Haritadaki geçerli konum
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Haritadaki geçerli bölge
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location : Location){
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location : Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        // Geçerli konum indexi
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else
        {
            print("Location dizisinde geçerli id elemanı bulunamadı !")
            return
        }
        
        // Sonraki index kontolü
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            
            // Sıradaki index dizide yer almıyorsa index Restart oluyor.
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Sonraki index aktarılıyor.
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
