//
//  CityTableViewCell.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/27/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

  
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
