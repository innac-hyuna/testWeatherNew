//
//  HistoryViewController.swift
//  testWeatherSw
//
//  Created by FE Team TV on 5/16/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD

@objc( History )
class History: NSManagedObject {
    @NSManaged  var idCity : String?
}

class HistoryViewController: UIViewController {
    
    var tableView: UITableView!
    var arrHistory: [CityGet] = []
    var historyCity: CityGet = CityGet()
    var arrId: [String] = []

    let managedObjectContext =
        (UIApplication.sharedApplication().delegate
            as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView =  UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
        setupLayout()
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName("History", inManagedObjectContext: self.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            var str = ""
            if (result.count > 0) {
               /*for his  in result {
               if let cityString =  his.valueForKey("idCity") {
                let cityStr = cityString as! String
                arrId.append(cityStr)
                }
               
              }*/
            arrId = result.map{ (his: AnyObject) -> String in
                    if let cityString =  his.valueForKey("idCity") {
                        str = cityString as! String
                        }
                    return str
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        let progressHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progressHUD.labelText = "Loading..."
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            self.historyCity = CityGet()
            self.arrHistory = self.historyCity.filterCity(self.historyCity.getCityArray(), arrId: self.arrId)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        }
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLayout() {
        
         view.addSubview(tableView)
        
        let  viewsDict = ["tableView" : tableView]
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
         view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
         view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-60-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
    }
    
}

// MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrHistory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CityTableViewCell  = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CityTableViewCell
            cell.his = true
            cell.cityLabel.text = arrHistory[indexPath.row].name;
            cell.countryLabel.text = arrHistory[indexPath.row].country;
            cell.idLabel.text = String(arrHistory[indexPath.row].id);
       
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let MyDetView: WeatherCityViewController = WeatherCityViewController()
        MyDetView.cityId = arrHistory[indexPath.row].id
        navigationController?.pushViewController(MyDetView, animated: true)
        
    }
    
}

// MARK: - UITableViewDelegate
extension HistoryViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
        
    }
    
}

