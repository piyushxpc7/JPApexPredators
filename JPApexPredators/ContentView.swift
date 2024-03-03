//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Chandra on 02/03/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    @State var searchtext = ""
    @State var alphabetical : Bool = false
    @State var currentSelection = PredatorType.all
    var filterDianos : [ApexPredator]{
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
       return  predators.search(for: searchtext)
    }
    
    
    var body: some View {
        NavigationStack{
            List(filterDianos){
                predator in
                NavigationLink{
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                }label : {
                    HStack{
                        //iMGE
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .shadow(radius: 1)
                        VStack(alignment: .leading){
                            Text(predator.name)
                                .fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical,5)
                                .padding(.horizontal,13)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                            
                            
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchtext)
            .autocorrectionDisabled()
            .animation(.default, value:  searchtext)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        withAnimation{
                            alphabetical.toggle()
                        }
                        
                    }
                label: {
                    if alphabetical{
                        Image(systemName: "film")
                    }
                    else {
                        Image(systemName: "textformat")
                    }
                }.symbolEffect(.bounce, value: alphabetical)
                }
                ToolbarItem(placement : .topBarTrailing){
                    Menu{
                        Picker("Filter",selection: $currentSelection.animation()){
                            ForEach(PredatorType.allCases){
                                type in
                                Label (type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label : {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
