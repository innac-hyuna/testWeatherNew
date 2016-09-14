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
        
        buttonHistory = UIButton(type: .custom) as UIButton
        buttonHistory.setImage(UIImage(named: "History.png"), for: UIControlState())
        buttonHistory.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        buttonHistory.addTarget(self, action: #selector(CitySViewController.historyView(_:)), for: .touchUpInside)
        
        let buttonItemHistory = UIBarButtonItem(customView: buttonHistory)
        buttonItemHistory.isEnabled = false
        barItemHistory = self.navigationItem
        barItemHistory.setRightBarButton(buttonItemHistory, animated: true)
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        locationButton = UIButton(type: UIButtonType.custom) as UIButton
        locationButton.setImage(UIImage(named: "Location1.png"), for: UIControlState())
        locationButton.setImage(UIImage(named: "Location.png"), for: UIControlState.selected)
        locationButton.addTarget(self, action: #selector(CitySViewController.locationGet(_:)), for: .touchUpInside)
        view.addSubview(locationButton)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
     
        tableView =  UITableView()
        tableView.separatorColor = UIColor.sepColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if arrCity.count == 0 {
           loadData() }
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          
    }
    
    func locationGet(_ sender:UIButton!) {
        
      let MyDetView: WeatherCityViewController = WeatherCityViewController()
       MyDetView.lat = locCoordination.0
       MyDetView.lon = locCoordination.1
       navigationController?.pushViewController(MyDetView, animated: true)
        
    }
    
    func historyView(_ sender: UIBarButtonItem) {
        let HistoryView: HistoryViewController = HistoryViewController()
        navigationController?.pushViewController(HistoryView, animated: true)
    }
    
    func loadData() {
        
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD?.labelText = "Loading..."

        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            self.arrCity = self.city.getCityArray()
            DispatchQueue.main.async {
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                self.buttonHistory.isEnabled = true
                self.view.endEditing(true)
                self.tableView.reloadData()
            }
        }
    }
    
 override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
     NSLayoutConstraint.activate(compactConstraints)
    
    }
    
 func setupLayout() {
    
        let topBar = self.topLayoutGuide
    
        let  viewsDict = [
            "searchBar" : searchBar,
            "locationButton" : locationButton,
            "tableView" : tableView] as [String : Any]
  
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[searchBar]-[locationButton(44)]-0-|", options: [], metrics: nil, views: viewsDict ))
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict ))        

        compactConstraints.append(NSLayoutConstraint(item: searchBar,
                           attribute: NSLayoutAttribute.topMargin,
                           relatedBy: NSLayoutRelation.lessThanOrEqual,
                           toItem: topBar,
                           attribute: NSLayoutAttribute.bottomMargin,
                           multiplier: 1.0,
                           constant: 10))
        compactConstraints.append( NSLayoutConstraint(item: locationButton,
                           attribute: NSLayoutAttribute.topMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: topBar,
                           attribute: NSLayoutAttribute.bottomMargin,
                           multiplier: 1.0,
                           constant: 10))
        
        NSLayoutConstraint(item: tableView,
                           attribute: NSLayoutAttribute.topMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: searchBar,
                           attribute: NSLayoutAttribute.bottomMargin,
                           multiplier: 1.0,
                           constant: 20).isActive = true
        NSLayoutConstraint(item: tableView,
                           attribute: NSLayoutAttribute.bottomMargin,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: view,
                           attribute: NSLayoutAttribute.bottomMargin,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }
    
    func pressed(_ sender: UIButton) {
        
        let newVC = WeatherCityViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }    
    
}

    // MARK: - UITableViewDataSource
extension CitySViewController: UITableViewDataSource {
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredArray.count
        }
        return arrCity.count
      }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:CityTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityTableViewCell
        
        if ((indexPath as NSIndexPath).row%2 == 0) {
            cell.backgroundColor = UIColor.oneCellColor()
        } else {
            cell.backgroundColor = UIColor.twoCellColor()}
       
        if(searchActive && filteredArray.count > 0){
            cell.cityLabel.text = filteredArray[(indexPath as NSIndexPath).row].name;
            cell.countryLabel.text = filteredArray[(indexPath as NSIndexPath).row].country;
            cell.idLabel.text = String(filteredArray[(indexPath as NSIndexPath).row].id);
        } else {
            cell.cityLabel.text = arrCity[(indexPath as NSIndexPath).row].name;
            cell.countryLabel.text = arrCity[(indexPath as NSIndexPath).row].country;
            cell.idLabel.text = String(arrCity[(indexPath as NSIndexPath).row].id);
        }
        return cell
      }
        
      @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
          let MyDetView: WeatherCityViewController = WeatherCityViewController()
                 
          if(searchActive) {
              MyDetView.cityId = filteredArray[(indexPath as NSIndexPath).row].id
          } else {
              MyDetView.cityId = arrCity[(indexPath as NSIndexPath).row].id
          }
        
        navigationController?.pushViewController(MyDetView, animated: true)
        let his = historyManadger()
        his.saveHistory(searchActive ? filteredArray : arrCity, indRow: (indexPath as NSIndexPath).row)        
        
    }

}

// MARK: - UITableViewDelegate
extension CitySViewController: UITableViewDelegate {
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {       
        return 50
    }

}

// MARK: - UISearchBarDelegate
extension CitySViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchActive = false
            self.tableView.reloadData()}
        else {
            searchActive = true
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchActive = false
         self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if searchText != "" {
          filteredArray.removeAll()
          filteredArray = city.filterCity(arrCity, strCity: searchText)
          searchActive = true
        } else {
          searchActive = false
        }
        
        self.tableView.reloadData()
    }
    
}

// MARK: - CLLocationManagerDelegate
extension CitySViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locCoordination = (locValue.latitude, locValue.longitude)
        
    }

}

