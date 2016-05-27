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


class CitySViewController: UIViewController{
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var locationButton: UIButton!
    var buttonHistory: UIButton!
    var barItemHistory: UINavigationItem!
    var navigationBar: UINavigationBar!
    var city: CityGet!
    var arrCity: [CityGet] = []
    var filteredArray: [CityGet] = []
    var searchActive: Bool = false
    var locCoordination: (Double, Double) = (0.0, 0.0)
    var locationManager: CLLocationManager!
    var regularConstraints = [NSLayoutConstraint]()
    var compactConstraints = [NSLayoutConstraint]()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonHistory = UIButton(type: .Custom) as UIButton
        buttonHistory.setImage(UIImage(named: "History.png"), forState: .Normal)
        buttonHistory.frame = CGRectMake(0, 0, 25, 25)
        buttonHistory.addTarget(self, action: #selector(CitySViewController.historyView(_:)), forControlEvents: .TouchUpInside)
        
        let buttonItemHistory = UIBarButtonItem(customView: buttonHistory)
        buttonItemHistory.enabled = false
        barItemHistory = self.navigationItem
        barItemHistory.setRightBarButtonItem(buttonItemHistory, animated: true)
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        locationButton = UIButton(type: UIButtonType.Custom) as UIButton
        locationButton.setImage(UIImage(named: "Location1.png"), forState: UIControlState.Normal)
        locationButton.setImage(UIImage(named: "Location.png"), forState: UIControlState.Selected)
        locationButton.addTarget(self, action: #selector(CitySViewController.locationGet(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(locationButton)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
     
        tableView =  UITableView()
        tableView.separatorColor = UIColor.sepColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        searchBar =  UISearchBar()
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        title = "Weather"
        city = CityGet()
        setupLayout()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if arrCity.count == 0 {
           loadData() }
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          
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
    
    func loadData() {
        
        let progressHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progressHUD.labelText = "Loading..."

        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            self.arrCity = self.city.getCityArray()
            dispatch_async(dispatch_get_main_queue()) {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.buttonHistory.enabled = true
                self.view.endEditing(true)
                self.tableView.reloadData()
            }
        }
    }
    
  override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    
    if UIDevice.currentDevice().orientation.isLandscape  {
        NSLayoutConstraint.deactivateConstraints(compactConstraints) //75
        NSLayoutConstraint.activateConstraints(regularConstraints)   //45
        
    } else {
        
        NSLayoutConstraint.deactivateConstraints(regularConstraints)
        NSLayoutConstraint.activateConstraints(compactConstraints)
    }
    
    
    }
      
 func setupLayout() {
       // let topBar = self.topLayoutGuide
        let  viewsDict = [
            "searchBar" : searchBar,
            "locationButton" : locationButton,
            "tableView" : tableView]
  
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[searchBar]-[locationButton(44)]-0-|", options: [], metrics: nil, views: viewsDict ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict ))
        
//Compact
        compactConstraints.append(NSLayoutConstraint(item: searchBar,
                           attribute: NSLayoutAttribute.TopMargin,
                           relatedBy: NSLayoutRelation.LessThanOrEqual,
                           toItem: view,
                           attribute: NSLayoutAttribute.TopMargin,
                           multiplier: 1.0,
                           constant: 75))
        compactConstraints.append( NSLayoutConstraint(item: locationButton,
                           attribute: NSLayoutAttribute.TopMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: view,
                           attribute: NSLayoutAttribute.TopMargin,
                           multiplier: 1.0,
                           constant: 75))
//Regular
       regularConstraints.append(NSLayoutConstraint(item: searchBar,
                           attribute: NSLayoutAttribute.TopMargin,
                           relatedBy: NSLayoutRelation.LessThanOrEqual,
                           toItem: view,
                           attribute: NSLayoutAttribute.TopMargin,
                           multiplier: 1.0,
                           constant: 45))
       regularConstraints.append(NSLayoutConstraint(item: locationButton,
                           attribute: NSLayoutAttribute.TopMargin,
                           relatedBy: NSLayoutRelation.LessThanOrEqual,
                           toItem: view,
                           attribute: NSLayoutAttribute.TopMargin,
                           multiplier: 1.0,
                           constant: 45))
        
        NSLayoutConstraint(item: tableView,
                           attribute: NSLayoutAttribute.TopMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: searchBar,
                           attribute: NSLayoutAttribute.BottomMargin,
                           multiplier: 1.0,
                           constant: 20).active = true
        NSLayoutConstraint(item: tableView,
                           attribute: NSLayoutAttribute.BottomMargin,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: view,
                           attribute: NSLayoutAttribute.BottomMargin,
                           multiplier: 1.0,
                           constant: 0).active = true
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
        
        if (indexPath.row%2 == 0) {
            cell.backgroundColor = UIColor.oneCellColor()
        } else {
            cell.backgroundColor = UIColor.twoCellColor()}
       
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
        let his = historyManadger()
        his.saveHistory(searchActive ? filteredArray : arrCity, indRow: indexPath.row)        
        
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
         self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
        if searchText != "" {
          filteredArray.removeAll()
          filteredArray = city.filterCity(arrCity, strCity: searchText)
        } else {
          searchActive = false;
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

