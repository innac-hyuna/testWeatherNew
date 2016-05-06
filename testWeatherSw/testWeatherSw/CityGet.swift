//
//  CityGet.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Foundation


class CityGet {
    
    private var city = CityData()
    
    func getCity() -> JSON {
        
        
        guard let path = NSBundle.mainBundle().pathForResource("city", ofType: "JSON")  else {
            return true
        }
        
        guard let data = try? NSData(contentsOfFile: path, options:.DataReadingUncached)   else {
            return true
        }
        
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
               arrCity.append(cityD)
            
                }
        
       return arrCity
    }
    
}
