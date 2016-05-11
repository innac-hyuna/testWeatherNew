//
//  Downloader.swift
//  testWeatherSw
//
//  Created by FE Team TV on 5/5/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation

class HttpDownloader {
    
    class func loadFileSync(url: String)-> Void {
      
    if let jsonUrl = NSURL(string: url) {
   
      let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.ApplicationDirectory, inDomains: .UserDomainMask).first! as NSURL
      let destinationUrl = documentsUrl.URLByAppendingPathComponent(jsonUrl.lastPathComponent!)
      print(destinationUrl)
   
      if NSFileManager().fileExistsAtPath(destinationUrl.path!) {
        print("The file already exists at path")
      } else {
        if let myJsonDataFromUrl = NSData(contentsOfURL: jsonUrl){   
         if myJsonDataFromUrl.writeToURL(destinationUrl, atomically: true) {
          print("file saved")
          } else {
          print("error saving file")
         }
      }
     }
    }
    
  }
}