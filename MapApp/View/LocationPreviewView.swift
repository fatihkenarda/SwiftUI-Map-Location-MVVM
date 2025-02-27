//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Fatih Kenarda on 15.06.2024.
//

import SwiftUI

struct LocationPreviewView: View {
    let location: Location
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageSection
                textSection
            }
            VStack(spacing: 8) {
                learnMoreButtonSection
                nextButtonSection
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

#Preview {
    ZStack {
        Color.mint.ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
    .environmentObject(LocationViewModel())
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageNames = location.imageNames.first {
                Image(imageNames)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var textSection: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButtonSection: some View {
        Button(action: {
            locationViewModel.sheetLocation = location
        }, label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 40)
        })
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButtonSection: some View {
        Button(action: {
            locationViewModel.nextButtonPressed()
        }, label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 40)
        })
        .buttonStyle(.bordered)
    }

}
