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
    var tempView: UIView!
    var mainView: UIView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainView = UIView()
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        tempView = UIView()
        contentView.addSubview(tempView)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel = UILabel()
        mainView.addSubview(mainLabel)
        mainLabel.font =  UIFont.HelTextFont(10)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        windsLabel = UILabel()
        mainView.addSubview(windsLabel)
        windsLabel.font =  UIFont.HelTextFont(10)
        windsLabel.translatesAutoresizingMaskIntoConstraints = false

        minvalLabel = UILabel()
        tempView.addSubview(minvalLabel)
        minvalLabel.font =  UIFont.HelTextFont(12)
        minvalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        maxvalLabel = UILabel()
        tempView.addSubview(maxvalLabel)
        maxvalLabel.font =  UIFont.HelTextFont(12)
        maxvalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel = UILabel()
        contentView.addSubview(dateLabel)
        dateLabel.font =  UIFont.HelTextFont(14)
        dateLabel.textColor = UIColor.mainTextColor()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weatherImg = UIImageView()
        contentView.addSubview(weatherImg)
        weatherImg.contentMode = UIViewContentMode.scaleAspectFit;
        weatherImg.translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupLayout() {
        
        
        NSLayoutConstraint(item: weatherImg,
                           attribute: NSLayoutAttribute.topMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.topMargin,
                           multiplier: 1.0,
                           constant: 10).isActive = true
         NSLayoutConstraint(item: weatherImg,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.leftMargin,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: weatherImg,
                           attribute: NSLayoutAttribute.bottomMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.bottomMargin,
                           multiplier: 1.0,
                           constant: 0 ).isActive = true
        
       NSLayoutConstraint(item: dateLabel,
                           attribute: NSLayoutAttribute.centerY,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.centerY,
                           multiplier: 1.0,
                           constant: -10).isActive = true
       NSLayoutConstraint(item: dateLabel,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: weatherImg,
                           attribute: NSLayoutAttribute.rightMargin,
                           multiplier: 1.0,
                           constant: 15).isActive = true
        
        NSLayoutConstraint(item: tempView,
                           attribute: NSLayoutAttribute.centerY,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.centerY,
                           multiplier: 1.0,
                           constant: -10).isActive = true
        NSLayoutConstraint(item: tempView,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: dateLabel,
                           attribute: NSLayoutAttribute.rightMargin,
                           multiplier: 1.0,
                           constant: 20).isActive = true
        NSLayoutConstraint(item: tempView,
                           attribute: NSLayoutAttribute.width,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: nil,
                           attribute: NSLayoutAttribute.notAnAttribute,
                           multiplier: 1.0,
                           constant: 45).isActive = true
        
        NSLayoutConstraint(item: mainView,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: weatherImg,
                           attribute: NSLayoutAttribute.rightMargin,
                           multiplier: 1.0,
                           constant: 30).isActive = true
        NSLayoutConstraint(item: mainView,
                           attribute: NSLayoutAttribute.bottomMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.bottomMargin,
                           multiplier: 1.0,
                           constant: -10).isActive = true
        
        NSLayoutConstraint(item: minvalLabel,
                           attribute: NSLayoutAttribute.centerY,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: tempView,
                           attribute: NSLayoutAttribute.centerY,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: minvalLabel,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: tempView,
                           attribute: NSLayoutAttribute.leftMargin,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: maxvalLabel,
                           attribute: NSLayoutAttribute.centerY,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: tempView,
                           attribute: NSLayoutAttribute.centerY,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: maxvalLabel,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: minvalLabel,
                           attribute: NSLayoutAttribute.rightMargin,
                           multiplier: 1.0,
                           constant: 20).isActive = true
        
       NSLayoutConstraint(item: mainLabel,
                           attribute: NSLayoutAttribute.centerY,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: mainView,
                           attribute: NSLayoutAttribute.centerY,
                           multiplier: 1.0,
                           constant: 0).isActive = true
       NSLayoutConstraint(item: mainLabel,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: mainView,
                           attribute: NSLayoutAttribute.leftMargin,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
       NSLayoutConstraint(item: windsLabel,
                          attribute: NSLayoutAttribute.centerY,
                          relatedBy: NSLayoutRelation.equal,
                          toItem: mainView,
                          attribute: NSLayoutAttribute.centerY,
                          multiplier: 1.0,
                          constant: 0).isActive = true
        NSLayoutConstraint(item: windsLabel,
                           attribute: NSLayoutAttribute.leftMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: mainLabel,
                           attribute: NSLayoutAttribute.rightMargin,
                           multiplier: 1.0,
                           constant: 25).isActive = true
    }
    
}
