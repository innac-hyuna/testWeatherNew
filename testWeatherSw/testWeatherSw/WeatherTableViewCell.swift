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
        weatherImg.contentMode = UIViewContentMode.ScaleAspectFit;
        weatherImg.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
        NSLayoutConstraint(item: weatherImg,
                           attribute: NSLayoutAttribute.TopMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.TopMargin,
                           multiplier: 1.0,
                           constant: 10).active = true
         NSLayoutConstraint(item: weatherImg,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.LeftMargin,
                           multiplier: 1.0,
                           constant: 0).active = true
        NSLayoutConstraint(item: weatherImg,
                           attribute: NSLayoutAttribute.BottomMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.BottomMargin,
                           multiplier: 1.0,
                           constant: 0 ).active = true
        
       NSLayoutConstraint(item: dateLabel,
                           attribute: NSLayoutAttribute.CenterY,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.CenterY,
                           multiplier: 1.0,
                           constant: -10).active = true
       NSLayoutConstraint(item: dateLabel,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: weatherImg,
                           attribute: NSLayoutAttribute.RightMargin,
                           multiplier: 1.0,
                           constant: 15).active = true
        
        NSLayoutConstraint(item: tempView,
                           attribute: NSLayoutAttribute.CenterY,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.CenterY,
                           multiplier: 1.0,
                           constant: -10).active = true
        NSLayoutConstraint(item: tempView,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: dateLabel,
                           attribute: NSLayoutAttribute.RightMargin,
                           multiplier: 1.0,
                           constant: 20).active = true
        NSLayoutConstraint(item: tempView,
                           attribute: NSLayoutAttribute.Width,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: nil,
                           attribute: NSLayoutAttribute.NotAnAttribute,
                           multiplier: 1.0,
                           constant: 45).active = true
        
        NSLayoutConstraint(item: mainView,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: weatherImg,
                           attribute: NSLayoutAttribute.RightMargin,
                           multiplier: 1.0,
                           constant: 30).active = true
        NSLayoutConstraint(item: mainView,
                           attribute: NSLayoutAttribute.BottomMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.BottomMargin,
                           multiplier: 1.0,
                           constant: -10).active = true
        
        NSLayoutConstraint(item: minvalLabel,
                           attribute: NSLayoutAttribute.CenterY,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: tempView,
                           attribute: NSLayoutAttribute.CenterY,
                           multiplier: 1.0,
                           constant: 0).active = true
        NSLayoutConstraint(item: minvalLabel,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: tempView,
                           attribute: NSLayoutAttribute.LeftMargin,
                           multiplier: 1.0,
                           constant: 0).active = true
        
        NSLayoutConstraint(item: maxvalLabel,
                           attribute: NSLayoutAttribute.CenterY,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: tempView,
                           attribute: NSLayoutAttribute.CenterY,
                           multiplier: 1.0,
                           constant: 0).active = true
        NSLayoutConstraint(item: maxvalLabel,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: minvalLabel,
                           attribute: NSLayoutAttribute.RightMargin,
                           multiplier: 1.0,
                           constant: 20).active = true
        
       NSLayoutConstraint(item: mainLabel,
                           attribute: NSLayoutAttribute.CenterY,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: mainView,
                           attribute: NSLayoutAttribute.CenterY,
                           multiplier: 1.0,
                           constant: 0).active = true
       NSLayoutConstraint(item: mainLabel,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: mainView,
                           attribute: NSLayoutAttribute.LeftMargin,
                           multiplier: 1.0,
                           constant: 0).active = true
        
       NSLayoutConstraint(item: windsLabel,
                          attribute: NSLayoutAttribute.CenterY,
                          relatedBy: NSLayoutRelation.Equal,
                          toItem: mainView,
                          attribute: NSLayoutAttribute.CenterY,
                          multiplier: 1.0,
                          constant: 0).active = true
        NSLayoutConstraint(item: windsLabel,
                           attribute: NSLayoutAttribute.LeftMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: mainLabel,
                           attribute: NSLayoutAttribute.RightMargin,
                           multiplier: 1.0,
                           constant: 25).active = true
    }
    
}
