//
//  CityTableViewCell.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/27/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    
    var cityLabel: UILabel!
    var countryLabel: UILabel!
    var idLabel: UILabel!
    var delButton: UIButton!
    var his: Bool = false
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        cityLabel = UILabel()
        countryLabel = UILabel()
        idLabel = UILabel()
        
        
        cityLabel.textColor = UIColor.blackColor()
        countryLabel.textColor = UIColor.blackColor()
        idLabel.textColor = UIColor.blackColor()
        
        contentView.addSubview(cityLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(idLabel)
       
        if his {
            delButton = UIButton()
            contentView.addSubview(delButton)}

        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()      
        
    }
    
    func setupLayout() {
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
       
        
        cityLabel.font =  UIFont (name: "Helvetica Neue", size: 14)
        countryLabel.font =  UIFont (name: "Helvetica Neue", size: 12)
        idLabel.font =  UIFont (name: "Helvetica Neue", size: 10)
        
        var viewsDict: [String: AnyObject] = [
            "city" : cityLabel,
            "country" : countryLabel,
            "id" : idLabel ]
        
        if his {
          delButton.translatesAutoresizingMaskIntoConstraints = false
          viewsDict.updateValue(delButton, forKey: "del")
        }
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[city]-[country]-[id]" + (his ? "-[del]" : "") + "-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[city]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[country]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[id]-|", options: [], metrics: nil, views: viewsDict))
        if his {
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[del]-|", options: [], metrics: nil, views: viewsDict))}
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
