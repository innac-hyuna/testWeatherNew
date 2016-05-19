//
//  WeatherTableViewCell.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/28/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    var mainLabel: UILabel!
    var minvalLabel: UILabel!
    var maxvalLabel: UILabel!
    var windsLabel: UILabel!
    var dateLabel: UILabel!
    var weatherImg: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainLabel = UILabel()
        minvalLabel = UILabel()
        maxvalLabel = UILabel()
        windsLabel = UILabel()
        dateLabel = UILabel()
        weatherImg = UIImageView()
        
        mainLabel.textColor = UIColor.blackColor()
        minvalLabel.textColor = UIColor.blackColor()
        maxvalLabel.textColor = UIColor.blackColor()
        windsLabel.textColor = UIColor.blackColor()
        dateLabel.textColor = UIColor.blackColor()
       
        contentView.addSubview(mainLabel)
        contentView.addSubview(minvalLabel)
        contentView.addSubview(maxvalLabel)
        contentView.addSubview(windsLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherImg)
        setupLayout()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupLayout() {
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        minvalLabel.translatesAutoresizingMaskIntoConstraints = false
        maxvalLabel.translatesAutoresizingMaskIntoConstraints = false
        windsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImg.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = UIColor.whiteColor()
        mainLabel.font =  UIFont (name: "Helvetica Neue", size: 10)
        minvalLabel.font =  UIFont (name: "Helvetica Neue", size: 12)
        maxvalLabel.font =  UIFont (name: "Helvetica Neue", size: 12)
        windsLabel.font =  UIFont (name: "Helvetica Neue", size: 10)
        dateLabel.font =  UIFont (name: "Helvetica Neue", size: 14)
        weatherImg.contentMode = UIViewContentMode.ScaleAspectFit;
        
        let viewsDict = [
            "weatherImg" : weatherImg,
            "minvalLabel" : minvalLabel,
            "maxvalLabel" : maxvalLabel,
            "dateLabel" : dateLabel,
            "windsLabel" : windsLabel,
            "mainLabel" : mainLabel ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[weatherImg]-[dateLabel]-[minvalLabel]-[maxvalLabel]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[weatherImg]-[windsLabel]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[weatherImg]-[mainLabel]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[dateLabel]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[minvalLabel]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[maxvalLabel]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[dateLabel]-[mainLabel]-[windsLabel]", options: [], metrics: nil, views: viewsDict))}    

}
