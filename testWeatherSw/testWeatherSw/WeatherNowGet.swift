//
//  WeatherGet.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//


import UIKit
import SwiftyJSON
import Alamofire

class WeatherNowGet {
    
    private var weather = WeatherData()
    
   
    
    func getWeatherCity(cityID: Int) {
        let url = NSURL(string: stringWeather(cityID))
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithURL(url!) { [unowned self] (data, response, error) -> Void in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {// where httpResponse.statusCode == 200 {
                
                if httpResponse.statusCode == 200 {
                    print("update ui")
                    let parsedData = self.getDataFromJson(data!)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        NSNotificationCenter.defaultCenter().postNotificationName(constNotification.WeatherNowChange, object: parsedData, userInfo: nil)
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
    }
    
    func getDataFromJson(data: NSData) -> Array  <WeatherData>  {
        
        var arrWeather = [WeatherData]()
        
        let json = JSON(data: data)
        
        let weather = WeatherData()
        
        
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
        
        if let weatherImg =  downloadImage("http://openweathermap.org/img/w/\(json["weather"][0]["icon"].string!).png"){
               weather.imgW = weatherImg
        }

        arrWeather.append(weather)
        
        return arrWeather
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
    
    private func stringWeather(cityID: Int) -> String {
           let requestString = "http://api.openweathermap.org/data/2.5/weather?id=\(String(cityID))&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        return requestString
    }
    
    
}
