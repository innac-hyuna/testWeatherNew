//
//  WeatherTableViewCell.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/28/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var minvalLabel: UILabel!
    
    @IBOutlet weak var maxvalLabel: UILabel!
    
    @IBOutlet weak var windsLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
