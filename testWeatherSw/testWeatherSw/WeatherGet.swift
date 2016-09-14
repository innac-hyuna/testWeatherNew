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


class WeatherGet {
    
    
    var name: String = ""
    var main: String = ""
    var desription: String=""
    var minValue: Double = 0.0
    var maxValue: Double=0.0
    var windS: Double = 0.0
    var date: String = String()
    var imgW: String = ""
    
    func getWeatherCity(_ cityID: Int, dayCount: String, view: UIView, lat: Double, lon: Double) {
        let url = URL(string: stringWeather(cityID, dayCount: dayCount, lat: lat, lon: lon)!)
        
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD?.labelText = "Loading..."
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!) { [unowned self] (data, response, error) -> Void in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                return
            }
        if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
                   
                    let parsedData = self.getDataFromJson(data!)
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: constNotification.WeatherChange), object: parsedData, userInfo: nil)
                        MBProgressHUD.hideAllHUDs(for: view, animated: true)
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
    }
    
    
    func getDataFromJson(_ data: Data) -> Array  <WeatherGet> {
        
        
        let json = JSON(data: data)
       
        
        return json["list"].arrayValue.map { (subJson: JSON) -> WeatherGet in
            let weatherD:WeatherGet = WeatherGet()
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
            if let date = Date.init(jsonDate: "/Date\(String(describing: subJson["dt"].int))/") {
                weatherD.date = date.dateStringWithFormat("yyyy-MM-dd")
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
            
            return weatherD
        }
     
   }
   
        
    fileprivate func stringWeather(_ cityID: Int,  dayCount: String, lat: Double, lon: Double) -> String? {
        
        var requestString = ""
        
        if  cityID != 0 {
            requestString = "http://api.openweathermap.org/data/2.5/forecast/daily?id=\(String(cityID))&cnt=\(dayCount)&APPID=6a700a1e919dc96b0a98901c9f4bec47"}
        else {
            requestString = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(String(lat))&lon=\(String(lon))&cnt=\(dayCount)&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        }
  
        
        return requestString
    }    
    
}

// MARK: - NSDate
extension Date {
    init?(jsonDate: String) {
        
        let prefix = "/DateOptional("
        let suffix = ")/"
        // Check for correct format:
        if jsonDate.hasPrefix(prefix) && jsonDate.hasSuffix(suffix) {
            // Extract the number as a string:
            let from = jsonDate.characters.index(jsonDate.startIndex, offsetBy: prefix.characters.count)
            let to = jsonDate.characters.index(jsonDate.endIndex, offsetBy: -suffix.characters.count)
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
    
    func dateStringWithFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
