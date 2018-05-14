//
//  Location.swift
//  GrupiX-Final
//
//  Created by Cacttus Education 12 on 5/9/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit

class Location: NSObject {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(id: Int, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
