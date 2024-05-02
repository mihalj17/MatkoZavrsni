//
//  MapViewModel.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 29.04.2024..
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    
    private let dataBaseService: DataBaseService
    
    @Published var sightsInDjakovo = [Sight]()
    
    
    init(DataBaseService:DataBaseService){
        
        self.dataBaseService = DataBaseService
    }
    
    
    func fetchSightsDataFromDatabase(){
        
        dataBaseService.fetchSightsData { (sights,error) in
            
            if let error = error {
                    print("Error fetching user data: \(error)")
                } else if let sights = sights {
                    for sight in sights {
                        self.sightsInDjakovo.append(sight)
                        print("Latitude: \(sight.latitude), Longitude: \(sight.longitude), Name:\(sight.name), id: \(sight.id) ")
                    }
                }
        }
        
        
    }
    
    
    
}
