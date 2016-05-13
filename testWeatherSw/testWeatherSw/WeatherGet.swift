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
}

class WeatherGet {
    
    
    var name: String = ""
    var main: String = ""
    var desription: String=""
    var minValue: Double = 0.0
    var maxValue: Double=0.0
    var windS: Double = 0.0
    var date: NSDate = NSDate()
    var imgW: UIImage? = UIImage()
    
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
    
    
    func getDataFromJson(data: NSData) -> Array  <WeatherGet> {
        
        
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
            if let date = NSDate(jsonDate: "/Date" + String(subJson["dt"].int)+"/") {
                weatherD.date = date
            }
            if let weatherMain = subJson["weather"][0]["main"].string {
                weatherD.main = weatherMain
            }
            if let weatherDescription = subJson["weather"][0]["description"].string {
                weatherD.desription = weatherDescription
            }
            if let weatherImg =  downloadImage("http://openweathermap.org/img/w/\(subJson["weather"][0]["icon"].string!).png"){
                weatherD.imgW = weatherImg
            }
            
            return weatherD
        }
     
   }
    
    
    private func downloadImage(str: String) -> UIImage?{
        
        let url = NSURL(string: str)
        let data = NSData(contentsOfURL: url!)
        
        if let image = UIImage(data: data!) {
            return image
        } else {
            return nil
        }
    }
        
    private func stringWeather(cityID: Int,  dayCount: String, lat: Double, lon: Double) -> String? {
        
        var requestString = ""
        
        if  cityID != 0 {
            requestString = "http://api.openweathermap.org/data/2.5/forecast/daily?id=\(String(cityID))&cnt=\(dayCount)&APPID=6a700a1e919dc96b0a98901c9f4bec47"}
        else {
            requestString = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(String(lat))&lon=\(String(lon))&cnt=\(dayCount)&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        }
  
        
        return requestString
    }
    
    
}
