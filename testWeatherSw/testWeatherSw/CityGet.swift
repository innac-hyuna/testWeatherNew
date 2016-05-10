//
//  CityGet.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire



class CityGet {
    
    private var city = CityData()
    
    func getCity() -> JSON {
        
        
       guard let path = NSBundle.mainBundle().pathForResource("city", ofType: "JSON")  else {
            return true
        }
        
        guard let data = try? NSData(contentsOfFile: path, options:.DataReadingUncached)   else {
            return true
        }
      
        
      /*  HttpDownloader.loadFileSync("http://bulk.openweathermap.org/sample/city.list.json.gz")
        
       
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.ApplicationDirectory, inDomains: .UserDomainMask)[0]
       
        let fileURL = documentsURL.URLByAppendingPathComponent("city.list.json.gz")
        
        guard let data = try? NSData(contentsOfFile: fileURL.path!, options:.DataReadingUncached)   else {
            return true
        }
       let decompressedData : NSData = try! data.gunzippedData()*/
       
        let dictionary =  JSON(data:data)
        
        return dictionary
    
    }
   
    
    func getCityArray() -> Array<CityData> {
        
       var arrCity = [CityData]()
       let  json = getCity()
       
      for (_,subJson):(String, JSON) in json {
    
            let cityD:CityData = CityData.init()
            if let name = subJson["name"].string {
                  cityD.name = name
               }
               if let _id = subJson["_id"].int {
                  cityD.id = _id
               }
               if let country = subJson["country"].string {
                  cityD.country = country
               }
               if let lat = subJson["coord"]["lat"].double {
                  cityD.lat = lat
               }
               if let lon = subJson["coord"]["lon"].double {
                  cityD.lon = lon
               }
               arrCity.append(cityD)
            
                }
        
       return arrCity
    }
    
}
