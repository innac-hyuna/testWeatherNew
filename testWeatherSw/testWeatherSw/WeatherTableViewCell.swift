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
        
        mainLabel = UILabel()
        minvalLabel = UILabel()
        maxvalLabel = UILabel()
        windsLabel = UILabel()
        dateLabel = UILabel()
        weatherImg = UIImageView()
        tempView = UIView()
        mainView = UIView()
        
        mainLabel.textColor = UIColor.blackColor()
        minvalLabel.textColor = UIColor.blackColor()
        maxvalLabel.textColor = UIColor.blackColor()
        windsLabel.textColor = UIColor.blackColor()
        dateLabel.textColor = UIColor.blackColor()
       
        contentView.addSubview(mainLabel)
        contentView.addSubview(windsLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherImg)
        contentView.addSubview(tempView)
        contentView.addSubview(mainView)

        tempView.addSubview(minvalLabel)
        tempView.addSubview(maxvalLabel)
        
        mainView.addSubview(mainLabel)
        mainView.addSubview(windsLabel)

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
        tempView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel.font =  UIFont (name: "Helvetica Neue", size: 10)
        minvalLabel.font =  UIFont (name: "Helvetica Neue", size: 12)
        maxvalLabel.font =  UIFont (name: "Helvetica Neue", size: 12)
        windsLabel.font =  UIFont (name: "Helvetica Neue", size: 10)
        dateLabel.font =  UIFont (name: "Helvetica Neue", size: 14)
        dateLabel.textColor = UIColor.blueColor()
        weatherImg.contentMode = UIViewContentMode.ScaleAspectFit;
        
        
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
