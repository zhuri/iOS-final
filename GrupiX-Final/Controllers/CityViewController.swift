//
//  CityViewController.swift
//  GrupiX-Final
//
//  Created by Apple on 5/15/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    var city: City? = nil
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passData()
    }
    
    func passData() {
        self.nameLabel.text = self.city?.name
        self.latitudeLabel.text = self.city?.latitude
        self.longitudeLabel.text = self.city?.longitude
        self.imageView.image = self.image
    }

}
