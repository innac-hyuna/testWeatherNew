//
//  Downloader.swift
//  testWeatherSw
//
//  Created by FE Team TV on 5/5/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation

class HttpDownloader {
    
    class func loadFileSync(url: String)-> Bool{
        
    var result: Bool = false
        
    if let jsonUrl = NSURL(string: url) {
   
      let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).first! as NSURL
      let destinationUrl = documentsUrl.URLByAppendingPathComponent(jsonUrl.lastPathComponent!)
      print(destinationUrl)
   
      if NSFileManager().fileExistsAtPath(destinationUrl.path!) {
        print("The file already exists at path")
        result = true
       } else {
        
        if let myJsonDataFromUrl = NSData(contentsOfURL: jsonUrl){
            if Int64(myJsonDataFromUrl.length) < DiskStatus.freeDiskSpaceInBytes{
               if myJsonDataFromUrl.writeToURL(destinationUrl, atomically: true) {
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