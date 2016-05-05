//
//  CitySearchViewController.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import MBProgressHUD

class CitySViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var city = CityGet()
   
    var arrCity: Array<CityData> = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.delegate = self
       tableView.dataSource = self
       searchBar.delegate = self
    
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
      
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
            dispatch_async(dispatch_get_main_queue()) {
            self.arrCity = self.city.searchCity(searchBar.text!, json: self.city.getCity())
            dispatch_async(dispatch_get_main_queue()) {
                self.view.endEditing(true)
                self.tableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)}
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCity.count
    }
    
 
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
         let cell:CityTableViewCell  = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CityTableViewCell
         
         cell.cityLabel.text = arrCity[indexPath.row].name;
         cell.countryLabel.text = arrCity[indexPath.row].country;
         cell.idLabel.text = String(arrCity[indexPath.row].id);
    
         return cell
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue!.identifier == "Push" {
            
            let MyDetView: WeatherCityViewController = segue!.destinationViewController as! WeatherCityViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            
            MyDetView.cityId = self.arrCity[indexPath!.row].id
            
        }
    }
    
   
}
