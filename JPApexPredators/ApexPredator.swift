//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Chandra on 02/03/24.
//

import Foundation
import SwiftUI
import MapKit


struct ApexPredator : Decodable, Identifiable{
    let id: Int
    let name : String
    let type: PredatorType
    let latitude: Double
    let longitude : Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link : String
    
    var image : String{
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    var location: CLLocationCoordinate2D
    {
      CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable,Identifiable{
        let id : Int
        let movie : String
        let sceneDescription : String
    }
   
}
enum PredatorType : String , Decodable, CaseIterable,Identifiable{
    
    var id: PredatorType{self}
    
    case land
    case air
    case sea
    case all
    
    
    
    var background : Color //computed property
    {
        switch self {
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        case .all:
                .black
        }
    }
    var icon: String{
        switch self {
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        case .all:
            "square.stack.3d.up.fill"
        }
    }
   
   
   
}
