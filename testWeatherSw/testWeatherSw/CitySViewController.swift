//
//  CitySearchViewController.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation
import CoreData



class CitySViewController: UIViewController{
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var locationButton: UIButton!
    var buttonHistory: UIBarButtonItem!
    var city: CityGet!
    var arrCity: [CityGet] = []
    var filteredArray: [CityGet] = []
    var searchActive: Bool = false
    var locCoordination: (Double, Double) = (0.0, 0.0)
    var locationManager: CLLocationManager!
    let managedObjectContext =
        (UIApplication.sharedApplication().delegate
            as! AppDelegate).managedObjectContext
  
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonHistory = UIBarButtonItem(title: "History", style: .Plain, target: self, action: #selector(CitySViewController.historyView(_:)))
        buttonHistory.enabled = false
        
        self.navigationItem.setRightBarButtonItem(buttonHistory, animated: true)
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
       
        title = "Weather"
        tableView =  UITableView()
        searchBar =  UISearchBar()
        locationButton = UIButton(type: UIButtonType.System) as UIButton
        locationButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        locationButton.setTitle("Loc", forState: .Normal)
        locationButton.backgroundColor = UIColor.redColor()
        city = CityGet()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        locationButton.addTarget(self, action: #selector(CitySViewController.locationGet(_:)), forControlEvents: .TouchUpInside)
        
        setupLayout()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if arrCity.count == 0 {
            loatData()}
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func locationGet(sender:UIButton!) {
        
      let MyDetView: WeatherCityViewController = WeatherCityViewController()
       MyDetView.lat = locCoordination.0
       MyDetView.lon = locCoordination.1
       navigationController?.pushViewController(MyDetView, animated: true)
        
    }
    
    func historyView(sender: UIBarButtonItem) {
        let HistoryView: HistoryViewController = HistoryViewController()
        navigationController?.pushViewController(HistoryView, animated: true)
    }
    
    func loatData() {
        
        let progressHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progressHUD.labelText = "Loading..."

        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            self.arrCity = self.city.getCityArray()
            dispatch_async(dispatch_get_main_queue()) {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.view.endEditing(true)
                self.buttonHistory.enabled = true
                self.tableView.reloadData()
            }
        }
    }
    
    func setupLayout() {
        
        view.addSubview(searchBar)
        view.addSubview(locationButton)
        view.addSubview(tableView)
        
        let  viewsDict = [
            "searchBar" : searchBar,
            "locationButton" : locationButton,
            "tableView" : tableView]
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[searchBar]-[locationButton(30)]-0-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-60-[searchBar]-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-60-[locationButton]-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        
    }
    
    func pressed(sender: UIButton) {
        
        let newVC = WeatherCityViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }    
    
}

    // MARK: - UITableViewDataSource
extension CitySViewController: UITableViewDataSource {
    
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredArray.count
        }
        return arrCity.count
      }
    
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
        let cell:CityTableViewCell  = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CityTableViewCell
        
       
        if(searchActive){
            cell.cityLabel.text = filteredArray[indexPath.row].name;
            cell.countryLabel.text = filteredArray[indexPath.row].country;
            cell.idLabel.text = String(filteredArray[indexPath.row].id);

        } else {
            cell.cityLabel.text = arrCity[indexPath.row].name;
            cell.countryLabel.text = arrCity[indexPath.row].country;
            cell.idLabel.text = String(arrCity[indexPath.row].id);

        }
        return cell
      }
        
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
          let MyDetView: WeatherCityViewController = WeatherCityViewController()
        
          if(searchActive){
              MyDetView.cityId = filteredArray[indexPath.row].id
            
          } else {
              MyDetView.cityId = arrCity[indexPath.row].id
            
          }
        
        navigationController?.pushViewController(MyDetView, animated: true)
        
        let entityDescription =
            NSEntityDescription.entityForName("History",
                                              inManagedObjectContext: managedObjectContext)
        
        let historyData = History(entity: entityDescription!,
                               insertIntoManagedObjectContext: managedObjectContext)
        
        var idCity: String
        if(searchActive){
           idCity = String(filteredArray[indexPath.row].id);
            
        } else {
           idCity = String(arrCity[indexPath.row].id);
        }
        
        historyData.idCity = idCity
        
        do {
            try managedObjectContext.save()
        } catch {
            
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
     }
    
 }

// MARK: - UITableViewDelegate
extension CitySViewController: UITableViewDelegate {
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        return 50
    
    }

}

// MARK: - UISearchBarDelegate
extension CitySViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
         searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
         searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
         searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
        filteredArray.removeAll()
        
        filteredArray = city.filterCity(arrCity, strCity: searchText)
        
        if(filteredArray.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
        
    }
    
}

// MARK: - CLLocationManagerDelegate
extension CitySViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locCoordination = (locValue.latitude, locValue.longitude)
        
    }

}

