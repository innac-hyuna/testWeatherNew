//
//  WeatherGet.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//


import UIKit
import SwiftyJSON
import MBProgressHUD


class WeatherGetH {
    
    var name: String = ""
    var main: String = ""
    var desription: String=""
    var minValue: Double = 0.0
    var maxValue: Double=0.0
    var windS: Double = 0.0
    var date: String = ""
    var imgW: String = ""
    
    func getWeatherCity(cityID: Int, dayCount: String, view: UIView, lat: Double, lon: Double) {
        let url = NSURL(string: stringWeather(cityID, dayCount: dayCount, lat: lat, lon: lon)!)
        
        let progressHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progressHUD.labelText = "Loading..."
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithURL(url!) { [unowned self] (data, response, error) -> Void in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                return
            }
        if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode == 200 {
                   
                    let parsedData = self.getDataFromJson(data!)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        NSNotificationCenter.defaultCenter().postNotificationName(constNotification.WeatherChange, object: parsedData, userInfo: nil)
                        MBProgressHUD.hideAllHUDsForView(view, animated: true)
                    }
                    
                }
                
            }
            
        }
        task.resume()
    }
    
    
    func getDataFromJson(data: NSData) -> Dictionary <String, Array <WeatherGetH>> {
        
        
        let json = JSON(data: data)       
        var dicWeather: [String: Array<WeatherGetH>] = [:]
        var arrWeather: [WeatherGetH] = []
        var dayLast = ""
        
        if let date = NSDate(jsonDate: "/Date" + String(json["list"][0]["dt"].int)+"/") {
           dayLast = date.dateStringWithFormat("yyyy-MM-dd")
        }
        
        for (_, subJson): (String, JSON) in  json["list"]
          {
          
                
            let weatherD:WeatherGetH = WeatherGetH()
            
            if let date = NSDate(jsonDate: "/Date" + String(subJson["dt"].int)+"/") {
                weatherD.date = date.dateStringWithFormat("yyyy-MM-dd HH:mm")
            }
            
            if let name = json["city"]["name"].string {
                weatherD.name = name
            }
            if let mainMinTemp = subJson["temp"]["min"].double {
                weatherD.minValue = mainMinTemp
            }
            if let mainMaxTemp = subJson["temp"]["max"].double{
                weatherD.maxValue = mainMaxTemp
            }
            if let windS = subJson["speed"].double {
                weatherD.windS = windS
            }
            if let weatherMain = subJson["weather"][0]["main"].string {
                weatherD.main = weatherMain
            }
            if let weatherDescription = subJson["weather"][0]["description"].string {
                weatherD.desription = weatherDescription
            }
            if let weatherImg =  "http://openweathermap.org/img/w/\(subJson["weather"][0]["icon"].string!).png" as String? {
                weatherD.imgW = weatherImg
            }
           
            
            if (weatherD.date.getDateD() == dayLast) {
                arrWeather.append(weatherD)
                dayLast = weatherD.date.getDateYMD()
               } else
             { dicWeather.updateValue(arrWeather, forKey: weatherD.date.getDateYMD())
               arrWeather.removeAll()}
            
        }
      return dicWeather
   }   
        
    private func stringWeather(cityID: Int,  dayCount: String, lat: Double, lon: Double) -> String? {
        
        var requestString = ""
        
        if  cityID != 0 {
           // requestString = "http://api.openweathermap.org/data/2.5/forecast/daily?id=\(String(cityID))&cnt=\(dayCount)&APPID=6a700a1e919dc96b0a98901c9f4bec47"
           requestString = "http://api.openweathermap.org/data/2.5/forecast?id=\(String(cityID))&cnt=\(dayCount)&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        }
        else {
            requestString = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(String(lat))&lon=\(String(lon))&cnt=\(dayCount)&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        }
        
        return requestString
    }
    
}

// MARK: - NSDate
extension NSDate {
    convenience init?(jsonDate: String) {
        
        let prefix = "/DateOptional("
        let suffix = ")/"
        // Check for correct format:
        if jsonDate.hasPrefix(prefix) && jsonDate.hasSuffix(suffix) {
            // Extract the number as a string:
            let from = jsonDate.startIndex.advancedBy(prefix.characters.count)
            let to = jsonDate.endIndex.advancedBy(-suffix.characters.count)
            // Convert milleseconds to double
            guard let milliSeconds = Double(jsonDate[from ..< to]) else {
                return nil
            }
            // Create NSDate with this UNIX timestamp
            self.init(timeIntervalSince1970: milliSeconds)
        } else {
            return nil
        }
    }
    
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
}




