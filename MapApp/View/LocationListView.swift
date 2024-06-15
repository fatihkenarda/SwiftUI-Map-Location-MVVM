//
//  LocationListView.swift
//  MapApp
//
//  Created by Fatih Kenarda on 14.06.2024.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationViewModel: LocationViewModel
    
    var body: some View {
        List{
            ForEach(locationViewModel.locations){ location in
                Button{
                    locationViewModel.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 3)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationViewModel())
}

extension LocationListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
