//
//  myRegion.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 29.04.2024..
//

import Foundation
import MapKit

extension MKCoordinateRegion{
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
