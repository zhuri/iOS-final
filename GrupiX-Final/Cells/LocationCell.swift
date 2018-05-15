//
//  LocationCell.swift
//  GrupiX-Final
//
//  Created by Cacttus Education 12 on 5/9/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews(with location: Location) {
        self.nameLabel.text = location.name
        self.latitudeLabel.text = String(format:"%f", location.latitude)
        self.longitudeLabel.text = String(format:"%f", location.longitude)
    }
}
