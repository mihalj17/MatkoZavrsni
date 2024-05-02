//
//  ContentView.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 29.04.2024..
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
   
    
    var body: some View {
        let dataBaseService = DataBaseService()
        return MapView(viewModel: MapViewModel(DataBaseService: dataBaseService))
    }

   

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
