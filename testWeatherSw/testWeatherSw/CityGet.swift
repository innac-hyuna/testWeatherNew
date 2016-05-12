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


class CityGet {
    
    private var city = CityData()
    
    func getCity() -> JSON {
      
        var dataConvert: NSData?
        
      if HttpDownloader.loadFileSync("http://bulk.openweathermap.org/sample/city.list.json.gz") {
        
      let fileManager = NSFileManager.defaultManager()
      let documentsURL = fileManager.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
       
       /* do {
            let documentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0])
            let originPath = documentDirectory.URLByAppendingPathComponent("/city.list.json.gz")
            let destinationPath = documentDirectory.URLByAppendingPathComponent("/city.gz")
            try NSFileManager.defaultManager().moveItemAtURL(originPath, toURL: destinationPath)
        } catch let error as NSError {
            print(error)
        }*/
        
       let fileURL = documentsURL.URLByAppendingPathComponent("city.list.json.gz")
        
      guard let data = try? NSData(contentsOfFile: fileURL.path!, options:.DataReadingUncached)   else {
            return true
      }
      let decompressedData : NSData = try! data.gunzippedData()
      let resstr = NSString(data: decompressedData, encoding: NSUTF8StringEncoding)
      let res2 = "[" + resstr!.stringByReplacingOccurrencesOfString("\n", withString: ",") + "]" as String!
      dataConvert = res2.dataUsingEncoding(NSUTF8StringEncoding)}
      else {
        guard let path = NSBundle.mainBundle().pathForResource("city", ofType: "JSON")  else {
            return true
        }
        guard let data = try? NSData(contentsOfFile: path, options:.DataReadingUncached)  else {
            return true
        }
           dataConvert = data
        }
        
      let dictionary =  JSON(data:dataConvert!)
       
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
