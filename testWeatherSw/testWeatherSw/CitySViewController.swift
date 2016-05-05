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

   // @IBOutlet weak var tableView: UITableView!
    
  //  @IBOutlet weak var searchBar: UISearchBar!
    
    var tableView =  UITableView()
    var searchBar =  UISearchBar()
    var city = CityGet()
    var arrCity: Array<CityData> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Weather"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        
        tableView.registerClass(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let  viewsDict = [
            "searchBar" : searchBar,
            "tableView" : tableView]
        
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
       
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[searchBar]-0-|", options: [], metrics: nil, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-60-[searchBar]-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        
    }
    
    func pressed(sender: UIButton) {
        
        let newVC = WeatherCityViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
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
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.view.endEditing(true)
                self.tableView.reloadData()
              }
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        let MyDetView: WeatherCityViewController = WeatherCityViewController()
        MyDetView.cityId = self.arrCity[indexPath.row].id
       // self.presentViewController(MyDetView, animated: true,completion: nil)
        self.navigationController?.pushViewController(MyDetView, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
               
        if segue!.identifier == "Push" {
            let indexPath = sender as! NSIndexPath
            let MyDetView: WeatherCityViewController = segue!.destinationViewController as! WeatherCityViewController
            
            MyDetView.cityId = self.arrCity[indexPath.row].id
            
        }
    }
    
   
    
   
}
