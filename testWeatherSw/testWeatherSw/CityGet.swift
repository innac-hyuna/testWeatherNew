//  CityGet.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON


class CityGet {
    
    var id: Int = 0
    var name: String = ""
    var country: String = ""
    var lon: Double = 0.0
    var lat: Double = 0.0
    
    
    func getCity() -> JSON {
        
       var dataConvert: NSData?
        
      if HttpDownloader.loadFileSync("http://bulk.openweathermap.org/sample/city.list.json.gz") {
        
        let fileManager = NSFileManager.defaultManager()
        let documentsURL = fileManager.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
        
        let fileURL = documentsURL.URLByAppendingPathComponent("city.list.json.gz")
        
        guard let data = try? NSData(contentsOfFile: fileURL.path!, options:.DataReadingUncached)   else {
            return true
        }
        
        guard let decompressedData: NSData = try? data.gunzippedData() else {
            return true
        }
        
        let resstr = NSString(data: decompressedData, encoding: NSUTF8StringEncoding)
        let resReplace = "[" + resstr!.stringByReplacingOccurrencesOfString("\n", withString: ",") + "]" as String!
        dataConvert = resReplace.dataUsingEncoding(NSUTF8StringEncoding)}
      else {
        guard let path = NSBundle.mainBundle().pathForResource("city", ofType: "JSON")  else {
            return true
        }
        guard let data = try? NSData(contentsOfFile: path, options:.DataReadingUncached)  else {
            return true
        }
           dataConvert = data
      }
      let  dictionary =  JSON(data:dataConvert!)
    
      return dictionary
    
    }
    
    func getCityArray() -> Array<CityGet> {
        
     
       let  json = getCity()
        
        return json.arrayValue.map { (subJson: JSON) -> CityGet in
            
             let cityD = CityGet()
            
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
           
            return cityD }
     
    }
    
    func filterCity(arrC: Array<CityGet>, strCity: String = "", arrId: Array<String> = []) -> Array<CityGet> {
        
        var filteredArray:[CityGet] = []
        var arrCity: [CityGet] = []
        
        if arrC.count == 0 {
            arrCity = getCityArray()
        } else {
           arrCity = arrC
        }
                
        if !strCity.isEmpty {
            for cityFor in arrCity {
                if (cityFor.name.hasPrefix(strCity))  {
                    filteredArray.append(cityFor)
                }
            } } else {
            for cityFor in arrCity {
                
                let isSet = arrId.filter {(name: String) -> Bool in
                    if name == String(cityFor.id) { return true }
                    return false }
                if isSet.count != 0 { filteredArray.append(cityFor) }
            }
        }
        return filteredArray
    }
}
