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
    
    navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
    let navigationItem = UINavigationItem()
    navigationBar.items = [navigationItem]
    view.addSubview(navigationBar)
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    
    tableViewWeather = UITableView()
    tableViewWeather.delegate = self
    tableViewWeather.dataSource = self
    tableViewWeather.separatorColor = UIColor.sepColor()
    tableViewWeather.register(WeatherTableViewCell.self, forCellReuseIdentifier: "CellWeather")
    view.addSubview(tableViewWeather)
    tableViewWeather.translatesAutoresizingMaskIntoConstraints = false
    
    wnowView = UIView()
    view.addSubview(wnowView)
    wnowView.translatesAutoresizingMaskIntoConstraints = false
    
    weatherImg = UIImageView()
    wnowView.addSubview(weatherImg)
    weatherImg.translatesAutoresizingMaskIntoConstraints = false
    
    weathrSwitch = SWSegmentedControl(items: ["C", "F"])
    weathrSwitch.addTarget(self, action: #selector(WeatherCityViewController.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
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
    myComboBox.textAlignment =  NSTextAlignment.center
    view.addSubview(myComboBox)
    myComboBox.translatesAutoresizingMaskIntoConstraints = false
  
    view.backgroundColor =  UIColor.backGroundColor()
    
    setLayout()
    }
    
    func pressed(_ sender: UIButton) {
        
        let newVC = CitySViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        getWeatherNow.getWeatherCity(cityId, lat: lat, lon: lon)
        setupObserversNow()
        reloadData()
     }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        //if traitCollection.horizontalSizeClass = UIUserInterfaceSizeClass.Compact
        NSLayoutConstraint.activate(compactConstraints)
        
    }
    
   func setLayout() {
    
   let topBar = self.topLayoutGuide
    NSLayoutConstraint(item: navigationBar,
                       attribute: NSLayoutAttribute.topMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.topMargin,
                       multiplier: 1.0,
                       constant: 10).isActive = true
    
    compactConstraints.append( NSLayoutConstraint(item: navigationBar,
                       attribute: NSLayoutAttribute.height,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: topBar,
                       attribute: NSLayoutAttribute.height,
                       multiplier: 1.0,
                       constant: 0))
    
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.topMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.bottomMargin,
                       multiplier: 1.0,
                       constant: 15).isActive = true
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.width,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.width,
                       multiplier: 1.0,
                       constant: -130 ).isActive = true
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.leftMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.leftMargin,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: wnowView,
                       attribute: NSLayoutAttribute.height,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.notAnAttribute,
                       multiplier: 1.0,
                       constant: 40).isActive = true
    
    NSLayoutConstraint(item: weathrSwitch,
                       attribute: NSLayoutAttribute.topMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.bottomMargin,
                       multiplier: 1.0,
                       constant: 15).isActive = true
    NSLayoutConstraint(item: weathrSwitch,
                       attribute: NSLayoutAttribute.leftMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.rightMargin,
                       multiplier: 1.0,
                       constant: 10).isActive = true
    NSLayoutConstraint(item: weathrSwitch,
                       attribute: NSLayoutAttribute.height,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.notAnAttribute,
                       multiplier: 1.0,
                       constant: 40).isActive = true
    
    NSLayoutConstraint(item: dayLabel,
                       attribute: NSLayoutAttribute.topMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.bottomMargin,
                       multiplier: 1.0,
                       constant: 15).isActive = true
    NSLayoutConstraint(item: dayLabel,
                       attribute: NSLayoutAttribute.leftMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: weathrSwitch,
                       attribute: NSLayoutAttribute.rightMargin,
                       multiplier: 1.0,
                       constant: 15).isActive = true
    NSLayoutConstraint(item: dayLabel,
                       attribute: NSLayoutAttribute.height,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.notAnAttribute,
                       multiplier: 1.0,
                       constant: 40).isActive = true
    
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.topMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: navigationBar,
                       attribute: NSLayoutAttribute.bottomMargin,
                       multiplier: 1.0,
                       constant: 25).isActive = true
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.leftMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: dayLabel,
                       attribute: NSLayoutAttribute.rightMargin,
                       multiplier: 1.0,
                       constant: 20).isActive = true
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.width,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.notAnAttribute,
                       multiplier: 1.0,
                       constant: 20).isActive = true
    NSLayoutConstraint(item: myComboBox,
                       attribute: NSLayoutAttribute.height,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.notAnAttribute,
                       multiplier: 1.0,
                       constant: 20).isActive = true
    
    NSLayoutConstraint(item: tableViewWeather,
                       attribute: NSLayoutAttribute.topMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: myComboBox,
                       attribute: NSLayoutAttribute.bottomMargin,
                       multiplier: 1.0,
                       constant: 25).isActive = true
    NSLayoutConstraint(item: tableViewWeather,
                       attribute: NSLayoutAttribute.width,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.width,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: tableViewWeather,
                       attribute: NSLayoutAttribute.bottomMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: view,
                       attribute: NSLayoutAttribute.bottomMargin,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    
    NSLayoutConstraint(item: weatherImg,
                       attribute: NSLayoutAttribute.centerY,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.centerY,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: weatherImg,
                       attribute: NSLayoutAttribute.leftMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.leftMargin,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    
    NSLayoutConstraint(item: tempLabel,
                       attribute: NSLayoutAttribute.centerY,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.centerY,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: tempLabel,
                       attribute: NSLayoutAttribute.leftMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: nameCityLabel,
                       attribute: NSLayoutAttribute.rightMargin,
                       multiplier: 1.0,
                       constant: 25).isActive = true
    NSLayoutConstraint(item: tempLabel,
                       attribute: NSLayoutAttribute.width,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: nil,
                       attribute: NSLayoutAttribute.notAnAttribute,
                       multiplier: 1.0,
                       constant: 30).isActive = true
    
    NSLayoutConstraint(item: nameCityLabel,
                       attribute: NSLayoutAttribute.centerY,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.centerY,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: nameCityLabel,
                       attribute: NSLayoutAttribute.leftMargin,
                       relatedBy: NSLayoutRelation.equal,
                       toItem: weatherImg,
                       attribute: NSLayoutAttribute.rightMargin,
                       multiplier: 1.0,
                       constant: 20).isActive = true
    NSLayoutConstraint(item: nameCityLabel,
                       attribute: NSLayoutAttribute.width,
                       relatedBy: NSLayoutRelation.lessThanOrEqual,
                       toItem: wnowView,
                       attribute: NSLayoutAttribute.width,
                       multiplier: 1.0,
                       constant: -110).isActive = true
    
 }

 func reloadData() {
    
        getWeather.getWeatherCity(cityId, dayCount: self.myComboBox.text!, view: self.view, lat: lat, lon: lon)
        setupObservers()
    
     }
    
    fileprivate func setupObservers() {
       
        NotificationCenter.default.addObserver(self, selector: #selector(WeatherCityViewController.weatherData(_:)), name: NSNotification.Name(rawValue: constNotification.WeatherChange), object: nil)
     }
    
    fileprivate func setupObserversNow() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(WeatherCityViewController.weatherNowData(_:)), name: NSNotification.Name(rawValue: constNotification.WeatherNowChange), object: nil)
      
     }
    
    func weatherData(_ notificaion: Notification) {
        
        guard let arrWeather = notificaion.object as? Array<WeatherGet> else {
            return
        }
        arrW = arrWeather
        
        tableViewWeather.reloadData()
         
     }
    
    func weatherNowData(_ notificaion: Notification) {
        
        guard let arrWeather = notificaion.object as? WeatherNowGet else {
            return
        }
        arrWNow = arrWeather
        
        setDataWeatherToday()
        
     }
    
    func setDataWeatherToday() -> Void {
        
          nameCityLabel.text = arrWNow.name
          tempLabel.text =  convertToTemp(Int(arrWNow.maxValue))
       
           if let URL =  URL(string: arrWNow.imgW ) {
            let resource =  ImageResource(downloadURL: URL, cacheKey: arrWNow.imgW)
             weatherImg.kf_setImage(with: resource)
        }
        
    }
    
  
    func convertToTemp(_ kelvin: Int) -> String {
        
        if weathrSwitch.selectedSegmentIndex == 1 {
            return String(format:"%.0f F", Double(kelvin) * 9.0/5.0 - 459.67) // F
        }
        else  {
            return String(format:"%.0f C", Double(kelvin) - 273.15) // to C
        }
    }
    
    func switchIsChanged(_ weathrSwitch: UISwitch) {
        tempLabel.text =  convertToTemp(Int(arrWNow.maxValue))
        tableViewWeather.reloadData()
    }

}


// MARK: - UITableViewDelegate
extension WeatherCityViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrW.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:WeatherTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "CellWeather", for: indexPath) as! WeatherTableViewCell
        let weatherDay = arrW[(indexPath as NSIndexPath).row]        
        
        if ((indexPath as NSIndexPath).row%2 == 0) {
            cell.backgroundColor = UIColor.oneCellColor()
        } else {
            cell.backgroundColor = UIColor.twoCellColor()}
        
        cell.selectionStyle = .none
        cell.dateLabel.text =  weatherDay.date;
        cell.minvalLabel.text = "Min t : " + convertToTemp(
            Int(weatherDay.minValue));
        cell.maxvalLabel.text = "Max t : " + convertToTemp(
            Int(weatherDay.maxValue));
        cell.mainLabel.text = weatherDay.main + " : " + weatherDay.desription
        cell.windsLabel.text = "Wind speed : " +  String(format:"%.0f",  weatherDay.windS)        
        if let URL = URL(string: weatherDay.imgW) {
        let resource = ImageResource(downloadURL: URL, cacheKey: weatherDay.imgW)
            cell.weatherImg.kf_setImage(with: resource, placeholder:  UIImage(named:"placeholder.png"))
        }
        return cell
    }    

}

// MARK: - UITableViewDelegate
extension WeatherCityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }    
    
}

// MARK: - UITextFieldDelegate
extension WeatherCityViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
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
    
    func comboBox(_ textField: SRKComboBox, didSelectRow row: Int) {
        if textField == self.myComboBox {
            self.myComboBox.text = self.arrayForComboBox[row]
        }
    }
    
    func comboBoxNumberOfRows(_ textField: SRKComboBox) -> Int {
        if textField == self.myComboBox {
            return self.arrayForComboBox.count
        } else {
            return 0
        }
    }
    
    func comboBox(_ textField:SRKComboBox, textForRow row: Int) -> String {
        if textField == self.myComboBox {
            return self.arrayForComboBox[row]
        } else {
            return ""
        }
    }
    
    func comboBoxPresentingViewController(_ textField: SRKComboBox) -> UIViewController {
        return self
    }
    
    func comboBoxRectFromWhereToPresent(_ textField: SRKComboBox) -> CGRect {
        return textField.frame
    }
    
    func comboBoxFromBarButton(_ textField: SRKComboBox) -> UIBarButtonItem? {
        return nil
    }
    
    func comboBoxTintColor(_ textField: SRKComboBox) -> UIColor {
        return UIColor.twoCellColor()
    }
    
    func comboBoxToolbarColor(_ textField:SRKComboBox) -> UIColor {
        return UIColor.oneCellColor()
    }
    
    func comboBoxDidTappedCancel(_ textField:SRKComboBox) {
        textField.text = ""
    }
    
    func comboBoxDidTappedDone(_ textField:SRKComboBox) {
        
        reloadData()
    }
    
}




