//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Chandra on 03/03/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    @State var position : MapCameraPosition
    @State var satellite : Bool = false
    var body: some View {
        Map(position :$position){
            ForEach(predators.apexPredator){
                predator in
                Annotation(predator.name, coordinate: predator.location){
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(radius: 10)
                        .scaleEffect(x:-1)
                    
                }
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
        .overlay(alignment: .bottomTrailing){
            Button{
                satellite.toggle()
            }
        label: {
            Image(systemName: satellite ? "globe.america.fill": "globe.americas")
                .font(.largeTitle)
                .padding(3)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 5))
                .padding()
            
            
        }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredator[2].location, distance: 1000, heading: 250, pitch: 80)))
}
