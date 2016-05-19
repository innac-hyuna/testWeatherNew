//
//  File.swift
//  testWeatherSw
//
//  Created by FE Team TV on 5/18/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation
import CoreData

@objc( History )
class History: NSManagedObject {
    @NSManaged  var idCity : String?
    @NSManaged  var name : String?
    @NSManaged  var country : String?
    
}

class historyManadger {
    
    var request = NSFetchRequest(entityName: "History")
    let managedObjectContext =
        (UIApplication.sharedApplication().delegate
            as! AppDelegate).managedObjectContext
    
    func saveHistory(arrCity: [CityGet], indRow: Int) {
        
        let entityDescription =
            NSEntityDescription.entityForName("History",
                                              inManagedObjectContext: managedObjectContext)
        
        let historyData = History(entity: entityDescription!,
                                  insertIntoManagedObjectContext: managedObjectContext)
        
        var idCity: String
        var name: String
        var country: String
        
        idCity = String(arrCity[indRow].id);
        name = arrCity[indRow].name
        country = arrCity[indRow].country
        
        historyData.idCity = idCity
        historyData.name = name
        historyData.country = country
        
        do {
            try managedObjectContext.save()
        } catch {
            
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    func historyDel(arrHistory: Array <CityGet>, ind: Int) {
        
         request.returnsObjectsAsFaults = false
        do {
            let results = try managedObjectContext.executeFetchRequest(request)
            if results.count > 0 {
                for result: AnyObject in results{
                    if let idCity = result.valueForKey("idCity") {
                        if idCity as! String == String(arrHistory[ind].id){
                            managedObjectContext.deleteObject(result as! NSManagedObject)
                            print("idCity - " + (idCity as! String) )}}}
                do {
                    try managedObjectContext.save()
                } catch {
                    let fetchError = error as NSError
                    print(fetchError)
                }
                
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

    }
    func historyGetArray() -> Array<CityGet> {
        
        var arrHistory: [CityGet] = []
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(request)
            if (result.count > 0) {
                arrHistory = result.map{ (his: AnyObject) -> CityGet in
                    let CityD: CityGet = CityGet()
                    if let idCity =  his.valueForKey("idCity")  {
                        CityD.id = Int(idCity as! String)! }
                    if let name =  his.valueForKey("name")  {
                        CityD.name = name as! String  }
                    if let country =  his.valueForKey("country")  {
                        CityD.country = country as! String  }
                    
                    return CityD
                    
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
     return arrHistory
     
    }

}