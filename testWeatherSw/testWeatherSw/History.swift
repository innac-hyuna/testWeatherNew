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
        (UIApplication.shared.delegate
            as! AppDelegate).managedObjectContext
    
    func saveHistory(_ arrCity: [CityGet], indRow: Int) {
        
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "History",
                                              in: managedObjectContext)
        
        let historyData = History(entity: entityDescription!,
                                  insertInto: managedObjectContext)
        
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
    func historyDel(_ arrHistory: Array <CityGet>, ind: Int) {
        
         request.returnsObjectsAsFaults = false
        do {
            let results = try managedObjectContext.fetch(request)
            if results.count > 0 {
                for result: AnyObject in results{
                    if let idCity = result.value(forKey: "idCity") {
                        if idCity as! String == String(arrHistory[ind].id){
                            managedObjectContext.delete(result as! NSManagedObject)
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
            let result = try self.managedObjectContext.fetch(request)
            if (result.count > 0) {
                arrHistory = result.map{ (his: AnyObject) -> CityGet in
                    let CityD: CityGet = CityGet()
                    if let idCity =  his.value(forKey: "idCity")  {
                        CityD.id = Int(idCity as! String)! }
                    if let name =  his.value(forKey: "name")  {
                        CityD.name = name as! String  }
                    if let country =  his.value(forKey: "country")  {
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
