//
//  LocationService.swift
//  GrupiX-Final
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LocationService: NSObject {
    
    let URL = "http://rest-api-dev.trekandi.com/v1.0/cities/endrit/1"
    let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    typealias closure = (Bool,[City],Error?)-> Void

    override init() {
        print("location service constructor called")
    }
    
    func getLocations(completion: @escaping closure) {
        let url = URLComponents.init(string: self.URL)
        Alamofire.request((url?.url!)!, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                var cities: [City] = []
                let json = JSON.init(value)
                let data = json["result"].array
                
                for city in data!{
                    let cityObj = City.init(object: city)
                    cities.append(cityObj)
                }
                
                completion(true,cities,nil)
                
            case .failure(let error):
                self.onError(error: error);
                completion(false,[],error)
                break
            }
        }
    }
    
    func onError(error: Error) {
        print("\("error") \t \(error)")
    }
    
    
}
