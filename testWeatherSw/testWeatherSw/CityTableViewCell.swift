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
        
        if reuseIdentifier == "CellHistory"{ self.his = true }
       
        cityLabel = UILabel()
        cityLabel.textColor = UIColor.backGroundColor()
        cityLabel.font =  UIFont.HelTextFont(14)
        contentView.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        countryLabel = UILabel()
        countryLabel.textColor = UIColor.backGroundColor()
        countryLabel.font =  UIFont.HelTextFont(12)
        contentView.addSubview(countryLabel)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        idLabel = UILabel()
        idLabel.textColor = UIColor.backGroundColor()
        idLabel.font =  UIFont.HelTextFont(10)
        contentView.addSubview(idLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
       
        if his {
            delButton = UIButton()
            delButton.setTitle("Dell", for: UIControlState())
            delButton.backgroundColor = UIColor.brown
            contentView.addSubview(delButton)
        }

        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()      
        
    }
    
    func setupLayout() { 
        
        var viewsDict: [String: AnyObject] = [
            "city" : cityLabel,
            "country" : countryLabel,
            "id" : idLabel ]
        
        if his {
          delButton.translatesAutoresizingMaskIntoConstraints = false
          viewsDict.updateValue(delButton, forKey: "del")
        }
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[city]-[country(30)]-[id(40)]" + (his ? "-[del(40)]-0" : "") + "-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[city]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[country]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[id]-|", options: [], metrics: nil, views: viewsDict))
        if his {
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[del]-0-|", options: [], metrics: nil, views: viewsDict))}
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

