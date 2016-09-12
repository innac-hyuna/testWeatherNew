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
        
       var dataConvert: Data?
        
      if HttpDownloader.loadFileSync("http://bulk.openweathermap.org/sample/city.list.json.gz") {
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        
        /* do {
         let documentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0])
         let originPath = documentDirectory.URLByAppendingPathComponent("/city.list.json.gz")
         let destinationPath = documentDirectory.URLByAppendingPathComponent("/city.gz")
         try NSFileManager.defaultManager().moveItemAtURL(originPath, toURL: destinationPath)
         } catch let error as NSError {
         print(error)
         }*/
        
        let fileURL = documentsURL.appendingPathComponent("city.list.json.gz")
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: fileURL.path), options:.uncached)   else {
            return true
        }
        
        guard let decompressedData : Data = try? data.gunzippedData() else {
            return true
        }
        
        let resstr = NSString(data: decompressedData, encoding: String.Encoding.utf8.rawValue)
        let resReplace = "[" + resstr!.replacingOccurrences(of: "\n", with: ",") + "]" as String!
        dataConvert = resReplace?.data(using: String.Encoding.utf8)}
      else {
        guard let path = Bundle.main.path(forResource: "city", ofType: "JSON")  else {
            return true
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options:.uncached)  else {
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
    
    func filterCity(_ arrCity: Array<CityGet>, strCity: String = "", arrId: Array<String> = [] ) -> Array<CityGet> {
        
        var filteredArray:[CityGet] = []
        
        if !strCity.isEmpty {
            for cityFor in arrCity {
                if (cityFor.name.hasPrefix(strCity))  {
                    filteredArray.append(cityFor)
                }
            } }else{
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
