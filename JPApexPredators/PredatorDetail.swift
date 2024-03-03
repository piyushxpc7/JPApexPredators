//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Chandra on 03/03/24.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator : ApexPredator
    @State var position : MapCameraPosition
    var body: some View {
        GeometryReader{ geo in
            
            ScrollView{
                ZStack(alignment : .bottomTrailing){
                    Image (predator.type.rawValue).resizable().scaledToFit()
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5,height: geo.size.height/3)
                        .scaleEffect(x:-1)
                        .shadow(radius: 7)
                        .offset(y:20)
                    
                }
                VStack(alignment : .leading){
                    
                    
                    Text(predator.name)
                        .font(.largeTitle)
                    NavigationLink{
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000, heading: 250, pitch: 80)))
                    }
                label:{
                    Map(position: $position){
                        Annotation(predator.name, coordinate: predator.location){  Image(systemName: "mappin.and.ellipse")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .symbolEffect(.pulse)
                        }
                        .annotationTitles(.hidden)
                    }
                    .frame(height: 124)
                    .clipShape(.rect(cornerRadius: 15))
                    
                    .overlay(alignment: .trailing ){
                        Image(systemName: "greaterthan")
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing)
                }
                    .overlay(alignment: .topLeading ){
                        Text("Current Location")
                            .padding([.leading,.trailing],5)
                            .background(.black.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 15))
                    }
                }
                    
                    Text("Appears in ")
                        .font(.headline)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self){
                        movie in
                        Text("•" + movie)
                            .font(.headline)
                        
                    }
                    Text("Movie Moments")
                    
                        .font(.title)
                        .padding(.top,15)
                    ForEach(predator.movieScenes){
                        scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical,1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom,15)
                        
                    }
                    Text("Read More")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .frame(width: geo.size.width,alignment: .leading)
            }.ignoresSafeArea()
        }.toolbarBackground(.automatic)
    }
}

#Preview {
   
    PredatorDetail(predator: Predators().apexPredator[2],
                   position: . camera(MapCamera(centerCoordinate:
    Predators() .apexPredator[2].location, distance:
    30000)))

    
}
