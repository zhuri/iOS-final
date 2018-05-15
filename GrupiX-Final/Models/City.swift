//
//  City.swift
//  GrupiX-Final
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit
import SwiftyJSON

class City: NSObject {
    let name: String
    let latitude: String
    let longitude: String
    
    init(object: JSON) {
        self.name = object["name"].string!
        self.latitude = object["latitude"].string!
        self.longitude = object["longitude"].string!
    }
}
