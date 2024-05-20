//
//  DataBaseService.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 30.04.2024..
//

import Foundation
import Firebase

class DataBaseService {
    
    let db = Firestore.firestore()
    
    func fetchSightsData(completion: @escaping ([Sight]?, Error?) -> Void) {
        db.collection("sights").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var sights = [Sight]()
                for document in querySnapshot!.documents {
                    if let latitude = document.data()["latitude"] as? Double,
                       let longitude = document.data()["longitude"] as? Double,
                       let name = document.data()["name"] as? String,
                       let id = document.data()["id"] as? Int,
                       let category = document.data()["category"] as? String{
                        let sight = Sight(id: id, name: name, latitude: latitude, longitude: longitude, category:category)
                        sights.append(sight)
                    }
                }
                completion(sights, nil)
            }
        }
    }
    
    
}
