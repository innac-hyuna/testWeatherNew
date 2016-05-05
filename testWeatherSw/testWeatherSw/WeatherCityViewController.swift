//
//  WeatherCityViewController.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import SRKControls


extension NSDate {
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
}


class WeatherCityViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, SRKComboBoxDelegate, UITextFieldDelegate {
    
 
  
    @IBOutlet weak var weathrSwitch: UISwitch!
    
    @IBOutlet weak var tableViewWeather: UITableView!
    
    @IBOutlet weak var nameCityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var SRKCombo: SRKComboBox!
    
    
        var getWeather = WeatherGet()
        var getWeatherNow = WeatherNowGet()
        var arrW: Array<WeatherData> = []
        var arrWNow: Array<WeatherData> = []
        var wea: WeatherData = WeatherData()
        var cityId = 0
        let arrayForComboBox = ["7","10","16"]
        let defDay = "7"
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.SRKCombo.text = defDay
            tableViewWeather.delegate = self
            tableViewWeather.dataSource = self
            weathrSwitch.addTarget(self, action: Selector("switchIsChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            
        }
        
       override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(true)
        
        getWeatherNow.getWeatherCity(cityId)
        setupObserversNow()
       
        reloadData()
            
        }
   
    func reloadData() {
        
        getWeather.getWeatherCity(cityId, dayCount: self.SRKCombo.text!, view: self.view)
        setupObservers()
        
      }
        
       private func setupObservers() {
        
          NSNotificationCenter.defaultCenter().addObserver(self, selector: "weatherData:", name: constNotification.WeatherChange, object: nil)
        
       }
        private func setupObserversNow() {
            
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "weatherNowData:", name: constNotification.WeatherNowChange, object: nil)
       
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
        
        self.nameCityLabel.text = arrWNow[0].name
        self.tempLabel.text =  convertToTemp(Int(arrWNow[0].maxValue))
        self.weatherImg.image = arrWNow[0].imgW
        self.dateLabel.text = arrWNow[0].date.dateStringWithFormat("yyyy-MM-dd");
        tableViewWeather.reloadData()
    }
    
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
    
    
    func convertToTemp(kelvin: Int) -> String {
        if weathrSwitch.on {
            return String(format:"%.0f F", Double(kelvin) * 9.0/5.0 - 459.67) // F
        }
        else  {
            return String(format:"%.0f C", Double(kelvin) - 273.15) // to C
        }
    }
    
    func switchIsChanged(weathrSwitch: UISwitch) {
       setDataWeatherToday()
    }

    //MARK:- UITextFieldDelegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let txt = textField as? SRKComboBox {
            txt.delegateForComboBox = self
            txt.showOptions()
            return false
        }
        
        return true
    }
    
    //MARK:- SRKComboBoxDelegate
    
    func comboBox(textField:SRKComboBox, didSelectRow row:Int) {
        if textField == self.SRKCombo {
            self.SRKCombo.text = self.arrayForComboBox[row]
            reloadData()
            
        }
    }
    
    func comboBoxNumberOfRows(textField:SRKComboBox) -> Int {
        if textField == self.SRKCombo {
            return self.arrayForComboBox.count
        } else {
            return 0
        }
    }
    
    func comboBox(textField:SRKComboBox, textForRow row:Int) -> String {
        if textField == self.SRKCombo {
            return self.arrayForComboBox[row]
        } else {
            return ""
        }
    }
    
    func comboBoxPresentingViewController(textField:SRKComboBox) -> UIViewController {
        return self
    }
    
    func comboBoxRectFromWhereToPresent(textField:SRKComboBox) -> CGRect {
        return textField.frame
    }
    
    func comboBoxFromBarButton(textField:SRKComboBox) -> UIBarButtonItem? {
        return nil
    }
    
    func comboBoxTintColor(textField:SRKComboBox) -> UIColor {
        return UIColor.blackColor()
    }
    
    func comboBoxToolbarColor(textField:SRKComboBox) -> UIColor {
        return UIColor.whiteColor()
    }
    
    func comboBoxDidTappedCancel(textField:SRKComboBox) {
        textField.text = defDay
    }
    
    func comboBoxDidTappedDone(textField:SRKComboBox) {
        print("Let's do some action here")
    }

}

