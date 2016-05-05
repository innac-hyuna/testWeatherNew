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



class WeatherCityViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
   var weathrSwitch = UISwitch()
   var tableViewWeather = UITableView()
   var nameCityLabel = UILabel()
   var tempLabel = UILabel()
   var weatherImg = UIImageView()
   var pickerTextfield = UITextField()
   var itemPicker = UIPickerView()
   var celLabel = UILabel()
   var farLabel = UILabel()
   var dayLabel = UILabel()
   var getWeather = WeatherGet()
   var getWeatherNow = WeatherNowGet()
   var arrW: Array<WeatherData> = []
   var arrWNow: Array<WeatherData> = []
   var wea: WeatherData = WeatherData()
   var cityId = 0
   let arrayForComboBox = ["1","5","7","10","16"]
    
    
   override func viewDidLoad() {
    
    super.viewDidLoad()
            
     self.title = ""
    
     tableViewWeather.delegate = self
     tableViewWeather.dataSource = self
     itemPicker.delegate = self
     itemPicker.dataSource = self
    
    
     self.view.backgroundColor = UIColor.grayColor()
     tableViewWeather.backgroundColor = UIColor.grayColor()
     itemPicker.backgroundColor = UIColor.whiteColor()
     pickerTextfield.inputView = itemPicker
     pickerTextfield.text = arrayForComboBox[0]
     celLabel.text = "C"
     farLabel.text = "F"
     dayLabel.text = "Day"
    
     let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take
      navigationBar.backgroundColor = UIColor.grayColor()
     let navigationItem = UINavigationItem()
      navigationBar.items = [navigationItem]
    
     self.view.addSubview(navigationBar)
     self.view.addSubview(weatherImg)
     self.view.addSubview(nameCityLabel)
     self.view.addSubview(tempLabel)
     self.view.addSubview(pickerTextfield)
     self.view.addSubview(weathrSwitch)
     self.view.addSubview(tableViewWeather)
     self.view.addSubview(celLabel)
     self.view.addSubview(farLabel)
     self.view.addSubview(dayLabel)
    
    
     weathrSwitch.addTarget(self, action: #selector(WeatherCityViewController.switchIsChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)

    
     tableViewWeather.registerClass(WeatherTableViewCell.self, forCellReuseIdentifier: "CellWeather")
   
    
     let viewsDict = [
        "navigationBar" : navigationBar,
        "nameCityLabel" : nameCityLabel,
        "tempLabel" : tempLabel,
        "pickerTextfield" : pickerTextfield,
        "weatherImg" : weatherImg,
        "weathrSwitch" : weathrSwitch,
        "tableViewWeather" : tableViewWeather,
        "celLabel" : celLabel,
        "farLabel" : farLabel,
        "dayLabel" : dayLabel]
    
    
      tableViewWeather.translatesAutoresizingMaskIntoConstraints = false
      weatherImg.translatesAutoresizingMaskIntoConstraints = false
      nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
      tempLabel.translatesAutoresizingMaskIntoConstraints = false
      pickerTextfield.translatesAutoresizingMaskIntoConstraints = false
      weathrSwitch.translatesAutoresizingMaskIntoConstraints = false
      navigationBar.translatesAutoresizingMaskIntoConstraints = false
      celLabel.translatesAutoresizingMaskIntoConstraints = false
      farLabel.translatesAutoresizingMaskIntoConstraints = false
      dayLabel.translatesAutoresizingMaskIntoConstraints = false
    
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[navigationBar]-0-|", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[weatherImg(60)]-[nameCityLabel]-[dayLabel]-[pickerTextfield]-[celLabel]-[weathrSwitch]-[farLabel]-0-|", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-0-[tableViewWeather]-0-|", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|[weatherImg(60)]-[tempLabel]-0-|", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-20-[navigationBar]-30-[nameCityLabel]-[tempLabel]-20-[tableViewWeather]-|", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[weathrSwitch]", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[celLabel]", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[farLabel]", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[dayLabel]", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[pickerTextfield]", options: [], metrics: nil, views: viewsDict))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-80-[weatherImg(60)]", options: [], metrics: nil, views: viewsDict))
    
      nameCityLabel.textColor = UIColor.blueColor()
      nameCityLabel.font = UIFont (name: "Helvetica Neue", size: 14)
      tempLabel.font = UIFont (name: "Helvetica Neue", size: 14)
      pickerTextfield.borderStyle = UITextBorderStyle.Line
      weathrSwitch.onTintColor = UIColor.blueColor()
      dayLabel.font =  UIFont (name: "Helvetica Neue", size: 12)
    
    }
    
    func pressed(sender: UIButton) {
        
        let newVC = CitySViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(true)
  
        getWeatherNow.getWeatherCity(cityId)
        setupObserversNow()
        reloadData()
            
     }

    func reloadData() {
        
        getWeather.getWeatherCity(cityId, dayCount: self.pickerTextfield.text!, view: self.view)
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
          self.nameCityLabel.text = arrWNow[0].name
          self.tempLabel.text =  convertToTemp(Int(arrWNow[0].maxValue))
          self.weatherImg.image = arrWNow[0].imgW}
          
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  
        return 100.0
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

      func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayForComboBox.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrayForComboBox[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextfield.text = arrayForComboBox[row]
        self.view.endEditing(true)
        reloadData()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.view.endEditing(false)
        return false
    }
}

