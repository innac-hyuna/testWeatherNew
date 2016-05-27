//
//  WeatherCityViewController.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import SWSegmentedControl
import SRKControls
import Kingfisher

class WeatherCityViewController:  UIViewController{
    
    
    var weathrSwitch: SWSegmentedControl!
    var tableViewWeather: UITableView!
    var nameCityLabel: UILabel!
    var tempLabel: UILabel!
    var weatherImg: UIImageView!
    var celLabel: UILabel!
    var dayLabel: UILabel!
    var wnowView: UIView!
    var conView: UIView!
    var constNavBar: NSLayoutConstraint!
    var navigationBar: UINavigationBar!
    var getWeather: WeatherGet!
    var getWeatherNow: WeatherNowGet!
    var arrW: [WeatherGet] = []
    var arrWNow: WeatherNowGet = WeatherNowGet()
    var cityId = 0
    var lat = 0.00
    var lon = 0.00
    var myComboBox: SRKComboBox!
    let arrayForComboBox = ["1","5","7","10","16"]
    var regularConstraints = [NSLayoutConstraint]()
    var compactConstraints = [NSLayoutConstraint]()
    
    
   override func viewDidLoad() {
    
    super.viewDidLoad()
    
    getWeather = WeatherGet()
    getWeatherNow = WeatherNowGet()
    
    navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
    let navigationItem = UINavigationItem()
    navigationBar.items = [navigationItem]
    view.addSubview(navigationBar)
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    
    tableViewWeather = UITableView()
    tableViewWeather.delegate = self
    tableViewWeather.dataSource = self
    tableViewWeather.separatorColor = UIColor.sepColor()
    tableViewWeather.registerClass(WeatherTableViewCell.self, forCellReuseIdentifier: "CellWeather")
    view.addSubview(tableViewWeather)
    tableViewWeather.translatesAutoresizingMaskIntoConstraints = false
    
    wnowView = UIView()
    view.addSubview(wnowView)
    wnowView.translatesAutoresizingMaskIntoConstraints = false
    
    weatherImg = UIImageView()
    wnowView.addSubview(weatherImg)
    weatherImg.translatesAutoresizingMaskIntoConstraints = false
    
    weathrSwitch = SWSegmentedControl(items: ["C", "F"])
    weathrSwitch.addTarget(self, action: #selector(WeatherCityViewController.switchIsChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    view.addSubview(weathrSwitch)
    weathrSwitch.translatesAutoresizingMaskIntoConstraints = false
    
    nameCityLabel = UILabel()
    nameCityLabel.textColor = UIColor.mainTextColor()
    nameCityLabel.numberOfLines = 2
    nameCityLabel.font = UIFont.HelTextFont(14)
    wnowView.addSubview(nameCityLabel)
    nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
    
    tempLabel = UILabel()
    tempLabel.textColor = UIColor.onBlackTextColor()
    tempLabel.font =  UIFont.HelTextFont(14)
    wnowView.addSubview(tempLabel)
    tempLabel.translatesAutoresizingMaskIntoConstraints = false
    
    dayLabel = UILabel()
    dayLabel.text = "Day"
    dayLabel.textColor = UIColor.onBlackTextColor()
    dayLabel.font =   UIFont.HelTextFont(12)
    view.addSubview(dayLabel)
    dayLabel.translatesAutoresizingMaskIntoConstraints = false
    
    myComboBox = SRKComboBox()
    myComboBox.delegate = self
    myComboBox.text = arrayForComboBox[0]
    myComboBox.setBorder()
    myComboBox.textColor = UIColor.onBlackTextColor()
    myComboBox.textAlignment =  NSTextAlignment.Center
    view.addSubview(myComboBox)
    myComboBox.translatesAutoresizingMaskIntoConstraints = false
  
    view.backgroundColor =  UIColor.backGroundColor()
    
    setLayout()
    }
    
    func pressed(sender: UIButton) {
        
        let newVC = CitySViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(true)
        getWeatherNow.getWeatherCity(cityId, lat: lat, lon: lon)
        setupObserversNow()
        reloadData()
     }

    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
       // if  view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
        if UIDevice.currentDevice().orientation.isLandscape  {
            NSLayoutConstraint.deactivateConstraints(compactConstraints) //75
            NSLayoutConstraint.activateConstraints(regularConstraints)   //45
            
        } else {
            
            NSLayoutConstraint.deactivateConstraints(regularConstraints)
            NSLayoutConstraint.activateConstraints(compactConstraints)
        }
        
    }
    
   func setLayout() {
    
    NSLayoutConstraint(item: navigationBar,
                       attribute: NSLayoutAttribute.TopMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.TopMargin,
                       multiplier: 1.0,
                       constant: 10).active = true
    
    compactConstraints.append( NSLayoutConstraint(item: navigationBar,
                       attribute: NSLayoutAttribute.Height,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 75))
    regularConstraints.append( NSLayoutConstraint(item: navigationBar,
                       attribute: NSLayoutAttribute.Height,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 75))
    
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.TopMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.BottomMargin,
                       multiplier: 1.0,
                       constant: 15).active = true
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.Width,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.Width,
                       multiplier: 1.0,
                       constant: -130 ).active = true
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.LeftMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.LeftMargin,
                       multiplier: 1.0,
                       constant: 0).active = true
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.Height,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 40).active = true
    
    NSLayoutConstraint(item: weathrSwitch,
                       attribute: NSLayoutAttribute.TopMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.BottomMargin,
                       multiplier: 1.0,
                       constant: 15).active = true
    NSLayoutConstraint(item: weathrSwitch,
                       attribute: NSLayoutAttribute.LeftMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.RightMargin,
                       multiplier: 1.0,
                       constant: 10).active = true
    NSLayoutConstraint(item: weathrSwitch,
                       attribute: NSLayoutAttribute.Height,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 40).active = true
    
    NSLayoutConstraint(item: dayLabel,
                       attribute: NSLayoutAttribute.TopMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.BottomMargin,
                       multiplier: 1.0,
                       constant: 15).active = true
    NSLayoutConstraint(item: dayLabel,
                       attribute: NSLayoutAttribute.LeftMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: weathrSwitch,
                       attribute: NSLayoutAttribute.RightMargin,
                       multiplier: 1.0,
                       constant: 15).active = true
    NSLayoutConstraint(item: dayLabel,
                       attribute: NSLayoutAttribute.Height,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 40).active = true
    
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.TopMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.BottomMargin,
                       multiplier: 1.0,
                       constant: 25).active = true
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.LeftMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: dayLabel,
                       attribute: NSLayoutAttribute.RightMargin,
                       multiplier: 1.0,
                       constant: 20).active = true
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.Width,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 20).active = true
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.Height,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 20).active = true
    
    NSLayoutConstraint(item: tableViewWeather,
                       attribute: NSLayoutAttribute.TopMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: myComboBox,
                       attribute: NSLayoutAttribute.BottomMargin,
                       multiplier: 1.0,
                       constant: 25).active = true
    NSLayoutConstraint(item: tableViewWeather,
                       attribute: NSLayoutAttribute.Width,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.Width,
                       multiplier: 1.0,
                       constant: 0).active = true
    NSLayoutConstraint(item: tableViewWeather,
                       attribute: NSLayoutAttribute.BottomMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.BottomMargin,
                       multiplier: 1.0,
                       constant: 0).active = true
    
    NSLayoutConstraint(item: weatherImg,
                       attribute: NSLayoutAttribute.CenterY,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.CenterY,
                       multiplier: 1.0,
                       constant: 0).active = true
    NSLayoutConstraint(item: weatherImg,
                       attribute: NSLayoutAttribute.LeftMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.LeftMargin,
                       multiplier: 1.0,
                       constant: 0).active = true
    
    NSLayoutConstraint(item: tempLabel,
                       attribute: NSLayoutAttribute.CenterY,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.CenterY,
                       multiplier: 1.0,
                       constant: 0).active = true
    NSLayoutConstraint(item: tempLabel,
                       attribute: NSLayoutAttribute.LeftMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nameCityLabel,
                       attribute: NSLayoutAttribute.RightMargin,
                       multiplier: 1.0,
                       constant: 25).active = true
    NSLayoutConstraint(item: tempLabel,
                       attribute: NSLayoutAttribute.Width,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 30).active = true
    
    NSLayoutConstraint(item: nameCityLabel,
                       attribute: NSLayoutAttribute.CenterY,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.CenterY,
                       multiplier: 1.0,
                       constant: 0).active = true
    NSLayoutConstraint(item: nameCityLabel,
                       attribute: NSLayoutAttribute.LeftMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: weatherImg,
                       attribute: NSLayoutAttribute.RightMargin,
                       multiplier: 1.0,
                       constant: 20).active = true
    NSLayoutConstraint(item: nameCityLabel,
                       attribute: NSLayoutAttribute.Width,
                       relatedBy: NSLayoutRelation.LessThanOrEqual,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.Width,
                       multiplier: 1.0,
                       constant: -110).active = true
    
 }

 func reloadData() {
    
        getWeather.getWeatherCity(cityId, dayCount: self.myComboBox.text!, view: self.view, lat: lat, lon: lon)
        setupObservers()
    
     }
    
    private func setupObservers() {
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WeatherCityViewController.weatherData(_:)), name: constNotification.WeatherChange, object: nil)
     }
    
    private func setupObserversNow() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WeatherCityViewController.weatherNowData(_:)), name: constNotification.WeatherNowChange, object: nil)
      
     }
    
    func weatherData(notificaion: NSNotification) {
        
        guard let arrWeather = notificaion.object as? Array<WeatherGet> else {
            return
        }
        arrW = arrWeather
        
        tableViewWeather.reloadData()
         
     }
    
    func weatherNowData(notificaion: NSNotification) {
        
        guard let arrWeather = notificaion.object as? WeatherNowGet else {
            return
        }
        arrWNow = arrWeather
        
        setDataWeatherToday()
        
     }
    
    func setDataWeatherToday() -> Void {
        
          nameCityLabel.text = arrWNow.name
          tempLabel.text =  convertToTemp(Int(arrWNow.maxValue))
       
           if let URL =  NSURL(string: arrWNow.imgW ) {
            let resource = Resource(downloadURL: URL, cacheKey: arrWNow.imgW)
             weatherImg.kf_setImageWithResource(resource)
        }
     }
    
  
    func convertToTemp(kelvin: Int) -> String {
        
        if weathrSwitch.selectedSegmentIndex == 1 {
            return String(format:"%.0f F", Double(kelvin) * 9.0/5.0 - 459.67) // F
        }
        else  {
            return String(format:"%.0f C", Double(kelvin) - 273.15) // to C
        }
    }
    
    func switchIsChanged(weathrSwitch: UISwitch) {
        tempLabel.text =  convertToTemp(Int(arrWNow.maxValue))
        tableViewWeather.reloadData()
    }

}


// MARK: - UITableViewDelegate
extension WeatherCityViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrW.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:WeatherTableViewCell  = tableView.dequeueReusableCellWithIdentifier("CellWeather", forIndexPath: indexPath) as! WeatherTableViewCell
        let weatherDay = arrW[indexPath.row]        
        
        if (indexPath.row%2 == 0) {
            cell.backgroundColor = UIColor.oneCellColor()
        } else {
            cell.backgroundColor = UIColor.twoCellColor()}
        
        cell.selectionStyle = .None
        cell.dateLabel.text =  weatherDay.date;
        cell.minvalLabel.text = "Min t : " + convertToTemp(
            Int(weatherDay.minValue));
        cell.maxvalLabel.text = "Max t : " + convertToTemp(
            Int(weatherDay.maxValue));
        cell.mainLabel.text = weatherDay.main + " : " + weatherDay.desription
        cell.windsLabel.text = "Wind speed : " +  String(format:"%.0f",  weatherDay.windS)        
        if let URL = NSURL(string: weatherDay.imgW) {
        let resource = Resource(downloadURL: URL, cacheKey: weatherDay.imgW)
            cell.weatherImg.kf_setImageWithResource(resource, placeholderImage: UIImage(named:"placeholder.png"))}
        
        return cell
    }    

}

// MARK: - UITableViewDelegate
extension WeatherCityViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }    
    
}

// MARK: - UITextFieldDelegate
extension WeatherCityViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let txt = textField as? SRKComboBox {
            txt.delegateForComboBox = self
            txt.showOptions()
            return false
        }
            return true
    }
    
}

// MARK: - SRKComboBoxDelegate
extension WeatherCityViewController: SRKComboBoxDelegate {
    
    func comboBox(textField: SRKComboBox, didSelectRow row:Int) {
        if textField == self.myComboBox {
            self.myComboBox.text = self.arrayForComboBox[row]
        }
    }
    
    func comboBoxNumberOfRows(textField: SRKComboBox) -> Int {
        if textField == self.myComboBox {
            return self.arrayForComboBox.count
        } else {
            return 0
        }
    }
    
    func comboBox(textField:SRKComboBox, textForRow row:Int) -> String {
        if textField == self.myComboBox {
            return self.arrayForComboBox[row]
        } else {
            return ""
        }
    }
    
    func comboBoxPresentingViewController(textField: SRKComboBox) -> UIViewController {
        return self
    }
    
    func comboBoxRectFromWhereToPresent(textField: SRKComboBox) -> CGRect {
        return textField.frame
    }
    
    func comboBoxFromBarButton(textField: SRKComboBox) -> UIBarButtonItem? {
        return nil
    }
    
    func comboBoxTintColor(textField: SRKComboBox) -> UIColor {
        return UIColor.twoCellColor()
    }
    
    func comboBoxToolbarColor(textField:SRKComboBox) -> UIColor {
        return UIColor.oneCellColor()
    }
    
    func comboBoxDidTappedCancel(textField:SRKComboBox) {
        textField.text = ""
    }
    
    func comboBoxDidTappedDone(textField:SRKComboBox) {
        
        reloadData()
    }
    
}




