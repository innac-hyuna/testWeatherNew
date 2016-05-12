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

class WeatherCityViewController:  UIViewController{
    
    
    var weathrSwitch: SWSegmentedControl!
    var tableViewWeather: UITableView!
    var nameCityLabel: UILabel!
    var tempLabel: UILabel!
    var weatherImg: UIImageView!
    var celLabel: UILabel!
    var farLabel:UILabel!
    var dayLabel: UILabel!
    var getWeather: WeatherGet!
    var getWeatherNow: WeatherNowGet!
    var arrW: [WeatherData] = []
    var arrWNow: [WeatherData] = []
    var wea: WeatherData!
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
    farLabel = UILabel()
    dayLabel = UILabel()
    getWeather = WeatherGet()
    getWeatherNow = WeatherNowGet()
    wea = WeatherData()
    myComboBox = SRKComboBox()    
   
    weathrSwitch = SWSegmentedControl(items: ["C", "F"])
    weathrSwitch.setBackColor("#0066ff")
    weathrSwitch.setTinColor("#000066")
    myComboBox.setBorder("#000066")
    view.backgroundColor = UIColor.grayColor()
    tableViewWeather.backgroundColor = UIColor.grayColor()
    dayLabel.text = "Day"
    myComboBox.text = arrayForComboBox[0]
    
    tableViewWeather.delegate = self
    tableViewWeather.dataSource = self
    myComboBox.delegate = self
    
    let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take
      navigationBar.backgroundColor = UIColor.grayColor()
    let navigationItem = UINavigationItem()
      navigationBar.items = [navigationItem]
    
     view.addSubview(navigationBar)
     view.addSubview(weatherImg)
     view.addSubview(nameCityLabel)
     view.addSubview(tempLabel)
     view.addSubview(myComboBox)
     view.addSubview(weathrSwitch)
     view.addSubview(tableViewWeather)
     view.addSubview(farLabel)
     view.addSubview(dayLabel)
    
     weathrSwitch.addTarget(self, action: #selector(WeatherCityViewController.switchIsChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    
     tableViewWeather.registerClass(WeatherTableViewCell.self, forCellReuseIdentifier: "CellWeather")
    
     let viewsDict = [
        "navigationBar" : navigationBar,
        "nameCityLabel" : nameCityLabel,
        "tempLabel" : tempLabel,
        "myComboBox" : myComboBox,
        "weatherImg" : weatherImg,
        "weathrSwitch" : weathrSwitch,
        "tableViewWeather" : tableViewWeather,
        "farLabel" : farLabel,
        "dayLabel" : dayLabel]
    
      tableViewWeather.translatesAutoresizingMaskIntoConstraints = false
      weatherImg.translatesAutoresizingMaskIntoConstraints = false
      nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
      tempLabel.translatesAutoresizingMaskIntoConstraints = false
      myComboBox.translatesAutoresizingMaskIntoConstraints = false
      weathrSwitch.translatesAutoresizingMaskIntoConstraints = false
      navigationBar.translatesAutoresizingMaskIntoConstraints = false
      farLabel.translatesAutoresizingMaskIntoConstraints = false
      dayLabel.translatesAutoresizingMaskIntoConstraints = false
   
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[navigationBar]-0-|", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[weatherImg(60)]-[nameCityLabel]-[dayLabel]-[myComboBox]-[weathrSwitch]-[farLabel]-0-|", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[tableViewWeather]-0-|", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|[weatherImg(60)]-[tempLabel]-0-|", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-20-[navigationBar]-30-[nameCityLabel]-[tempLabel]-20-[tableViewWeather]-|", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[weathrSwitch]", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[farLabel]", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[dayLabel]", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[myComboBox]", options: [], metrics: nil, views: viewsDict))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[weatherImg(60)]", options: [], metrics: nil, views: viewsDict))
    
      nameCityLabel.textColor = UIColor.blueColor()
      nameCityLabel.font = UIFont (name: "Helvetica Neue", size: 14)
      tempLabel.font = UIFont (name: "Helvetica Neue", size: 14)
      dayLabel.font =  UIFont (name: "Helvetica Neue", size: 12)
    
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
        
        guard let arrWeather = notificaion.object as? Array<WeatherData> else {
            return
        }
        arrW = arrWeather
        
        setDataWeatherToday()
         
     }
    
    func weatherNowData(notificaion: NSNotification) {
        
        guard let arrWeather = notificaion.object as? Array<WeatherData> else {
            return
        }
        arrWNow = arrWeather
        
        setDataWeatherToday()
        
     }
    
    func setDataWeatherToday() -> Void {
        
        if arrWNow.count > 0 {
          nameCityLabel.text = arrWNow[0].name
          tempLabel.text =  convertToTemp(Int(arrWNow[0].maxValue))
          weatherImg.image = arrWNow[0].imgW}
          
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
       setDataWeatherToday()
    }

}

// MARK: - NSDate
extension NSDate {
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
}

// MARK: - UITextField
extension UITextField  {
    func setBorder(color: String)
    {
        self.borderStyle = UITextBorderStyle.None;
        let width = CGFloat(1.0)
        self.layer.borderColor =  UIColor(hexString: color).CGColor
        self.layer.borderWidth = width
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
    
    func tableView(tableViewWeather: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:WeatherTableViewCell  = tableViewWeather.dequeueReusableCellWithIdentifier("CellWeather", forIndexPath: indexPath) as! WeatherTableViewCell
        let weatherDay = arrW[indexPath.row]
        
        cell.dateLabel.text =  weatherDay.date.dateStringWithFormat("yyyy-MM-dd");
        cell.minvalLabel.text = "Min t : " + convertToTemp(
            Int(weatherDay.minValue));
        cell.maxvalLabel.text = "Max t : " + convertToTemp(
            Int(weatherDay.maxValue));
        cell.mainLabel.text = weatherDay.main + " : " + weatherDay.desription
        cell.windsLabel.text = "Wind speed : " +  String(format:"%.0f",  weatherDay.windS)
        cell.weatherImg.image = weatherDay.imgW
        
        return cell
    }

}

// MARK: - UITableViewDelegate
extension WeatherCityViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
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




