//
//  Predators.swift
//  JPApexPredators
//
//  Created by Chandra on 02/03/24.
//

import Foundation
class Predators{
    var apexPredator : [ApexPredator] = []
    init(){
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredator = try decoder.decode([ApexPredator].self, from: data)
            }
            catch{
                print("Error decoding")
            }
        }
    }
    func search(for searchTerm: String)-> [ApexPredator]{
        if searchTerm.isEmpty{
            return apexPredator
        }
        else {
            return apexPredator.filter{
                predator in predator.name.localizedStandardContains(searchTerm)
            }
        }
    }
    func sort(by alphabetical : Bool){
        apexPredator.sort{predator1,predator2 in
            if alphabetical {
                predator1.name<predator2.name
            }
            else {
                predator1.id < predator2.id
            }}
    }
}

