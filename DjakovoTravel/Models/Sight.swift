//
//  Sight.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 30.04.2024..
//

import Foundation
import MapKit

struct Sight: Identifiable, Hashable{
    
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var icon: String
    
    
    
    func toMKMapItem() -> MKMapItem {
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = name
            return mapItem
        }
}
