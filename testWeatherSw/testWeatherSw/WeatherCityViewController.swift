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
    
    
   override func viewDidLoad() {
    
    super.viewDidLoad()
    
    tableViewWeather = UITableView()
    nameCityLabel = UILabel()
    tempLabel = UILabel()
    weatherImg = UIImageView()
    celLabel = UILabel()
    dayLabel = UILabel()
    wnowView = UIView()
    getWeather = WeatherGet()
    getWeatherNow = WeatherNowGet()
    myComboBox = SRKComboBox()
    setViewElements()
    setLayout()
    
    tableViewWeather.delegate = self
    tableViewWeather.dataSource = self
    myComboBox.delegate = self
    
    weathrSwitch.addTarget(self, action: #selector(WeatherCityViewController.switchIsChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    
    tableViewWeather.registerClass(WeatherTableViewCell.self, forCellReuseIdentifier: "CellWeather")
    
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
    

    func setViewElements () {
        
        weathrSwitch = SWSegmentedControl(items: ["C", "F"])
        myComboBox.setBorder("#f1c40f")
        myComboBox.textColor = UIColor.whiteColor()
        myComboBox.textAlignment =  NSTextAlignment.Center
        tableViewWeather.backgroundColor = UIColor.blackColor()
        tableViewWeather.separatorColor = UIColor.yellowColor()
        dayLabel.textColor = UIColor.whiteColor()
        tempLabel.textColor = UIColor.whiteColor()
        view.backgroundColor = UIColor.blackColor()
        nameCityLabel.textColor = UIColor.blueColor()
        nameCityLabel.numberOfLines = 2
        nameCityLabel.font = UIFont (name: "Helvetica Neue", size: 14)
        tempLabel.font = UIFont (name: "Helvetica Neue", size: 14)
        dayLabel.font =  UIFont (name: "Helvetica Neue", size: 12)        
        dayLabel.text = "Day"
        myComboBox.text = arrayForComboBox[0]
        
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take
        navigationBar.backgroundColor = UIColor.grayColor()
        let navigationItem = UINavigationItem()
        navigationBar.items = [navigationItem]
        
        wnowView.addSubview(weatherImg)
        wnowView.addSubview(nameCityLabel)
        wnowView.addSubview(tempLabel)
        view.addSubview(dayLabel)
        view.addSubview(myComboBox)
        view.addSubview(weathrSwitch)
        view.addSubview(wnowView)
        view.addSubview(navigationBar)
        view.addSubview(tableViewWeather)
        
        tableViewWeather.translatesAutoresizingMaskIntoConstraints = false
        weatherImg.translatesAutoresizingMaskIntoConstraints = false
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        myComboBox.translatesAutoresizingMaskIntoConstraints = false
        weathrSwitch.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        wnowView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
   func setLayout() {
    
    
    NSLayoutConstraint(item: navigationBar,
                       attribute: NSLayoutAttribute.TopMargin,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.TopMargin,
                       multiplier: 1.0,
                       constant: 10).active = true
   
    NSLayoutConstraint(item: navigationBar,
                       attribute: NSLayoutAttribute.Height,
                       relatedBy: NSLayoutRelation.Equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.NotAnAttribute,
                       multiplier: 1.0,
                       constant: 70).active = true
    
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
        
        setDataWeatherToday()
         
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
        
          tableViewWeather.reloadData()
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


// MARK: - UITextField
extension UITextField  {
    func setBorder(color: String) {
    
        self.borderStyle = UITextBorderStyle.None;
        let width = CGFloat(1.0)
        self.layer.borderColor =  UIColor(hexString: color).CGColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
    
}
// MARK: - SWSegmentedControl
extension SWSegmentedControl  {
    func setBackColor(color: String) {
        self.backgroundColor = UIColor(hexString: color)
    }
    func setTinColor(color: String) {
        self.tintColor = UIColor(hexString: color)
    }
    
}
// MARK: - UITextField
extension UIColor {
    // Creates a UIColor from a Hex string.
    convenience init(hexString: String) {
        var cString: String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            self.init(white: 0.5, alpha: 1.0)
        } else {
            let rString: String = (cString as NSString).substringToIndex(2)
            let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
            let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
            
            var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
            NSScanner(string: rString).scanHexInt(&r)
            NSScanner(string: gString).scanHexInt(&g)
            NSScanner(string: bString).scanHexInt(&b)
            
            self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: CGFloat(1))
        }
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
            cell.backgroundColor = UIColor.grayColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor()}
        
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
        return UIColor.blackColor()
    }
    
    func comboBoxToolbarColor(textField:SRKComboBox) -> UIColor {
        return UIColor.whiteColor()
    }
    
    func comboBoxDidTappedCancel(textField:SRKComboBox) {
        textField.text = ""
    }
    
    func comboBoxDidTappedDone(textField:SRKComboBox) {
        
        reloadData()
    }
    
}




