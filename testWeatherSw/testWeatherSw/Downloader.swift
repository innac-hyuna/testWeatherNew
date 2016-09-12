//
//  Downloader.swift
//  testWeatherSw
//
//  Created by FE Team TV on 5/5/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation

class HttpDownloader {
    
    class func loadFileSync(_ url: String)-> Bool{
        
    var result: Bool = false
        
    if let jsonUrl = URL(string: url) {
   
      let documentsUrl =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first! as URL
      let destinationUrl = documentsUrl.appendingPathComponent(jsonUrl.lastPathComponent)
      print(destinationUrl)
   
      if FileManager().fileExists(atPath: destinationUrl.path) {
        print("The file already exists at path")
        result = true
       } else {
        
        if let myJsonDataFromUrl = try? Data(contentsOf: jsonUrl){
            if Int64(myJsonDataFromUrl.count) < DiskStatus.freeDiskSpaceInBytes{
               if (try? myJsonDataFromUrl.write(to: destinationUrl, options: [.atomic])) != nil {
                  print("file saved")
                  result = true
               } else {
                  print("error saving file")
                  result = false
                }}
        }else {
            print("error disk space")
            result = false
        }
      }
    }
     return result
  }
  
}
