//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by Fatih Kenarda on 18.06.2024.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        Image(systemName: "map.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .font(.headline)
            .foregroundColor(.white)
            .padding(6)
            .background(Color.accentColor)
            .cornerRadius(36)

        Image(systemName: "triangle.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.accentColor)
            .frame(width: 10, height: 10)
            .rotationEffect(Angle(degrees: 180))
            .offset(y: -10)
    }
}

#Preview {
    LocationMapAnnotationView()
}
