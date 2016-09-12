//
//  WeatherGet.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//


import UIKit
import SwiftyJSON
import Kingfisher


class WeatherNowGet {
    
    var name: String = ""
    var main: String = ""
    var desription: String = ""
    var minValue: Double = 0.0
    var maxValue: Double = 0.0
    var windS: Double = 0.0
    var imgW: String = ""
    
  
    func getWeatherCity(_ cityID: Int, lat: Double, lon: Double) {
        
        let url = URL(string: stringWeather(cityID, lat: lat, lon: lon)!)        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!) { [unowned self] (data, response, error) -> Void in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {// where httpResponse.statusCode == 200 {                
                if httpResponse.statusCode == 200 {
                    let parsedData = self.getDataFromJson(data!)
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: constNotification.WeatherNowChange), object: parsedData, userInfo: nil)
                    }
                }
            }            
        }
        
        task.resume()
    }
    
    func getDataFromJson(_ data: Data) -> WeatherNowGet  {
        
        
        let json = JSON(data: data)
        let weather = WeatherNowGet()
        
        if let name = json["name"].string {
            weather.name = name
        }
        if let mainMinTemp = json["main"]["temp_min"].double {
            weather.minValue = mainMinTemp
        }
        if let mainMaxTemp = json["main"]["temp_max"].double{
            weather.maxValue = mainMaxTemp
        }
        if let windS = json["wind"]["speed"].double {
                weather.windS = windS
        }
        if let weatherMain = json["weather"][0]["main"].string {
                weather.main = weatherMain
        }
        if let weatherDescription = json["weather"][0]["description"].string {
                weather.desription = weatherDescription
        }
        if let weatherImg =  "http://openweathermap.org/img/w/\(json["weather"][0]["icon"].string!).png" as String? {
               weather.imgW = weatherImg
        }
       
        
        return weather
    }
    
      
    fileprivate func stringWeather(_ cityID: Int, lat: Double, lon: Double) -> String? {
        
        var requestString = ""
        
        if  cityID != 0 {
            requestString = "http://api.openweathermap.org/data/2.5/weather?id=\(String(cityID))&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        } else  {
            requestString = "http://api.openweathermap.org/data/2.5/weather?lat=\(String(lat))&lon=\(String(lon))&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        }

        
        return requestString
    }
    
    
}
