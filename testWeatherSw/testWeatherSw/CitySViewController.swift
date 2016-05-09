//
//  CitySearchViewController.swift
//  testWeatherSw
//
//  Created by FE Team TV on 4/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import MBProgressHUD

class CitySViewController: UIViewController{

    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var city: CityGet!
    var arrCity: [CityData] = []
    var searchActive: Bool = false
    var filteredArray: [CityData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Weather"
        tableView =  UITableView()
        searchBar =  UISearchBar()
        city = CityGet()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    func loatData() {
        
        let progressHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progressHUD.labelText = "Loading..."

        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            self.arrCity = self.city.getCityArray()
            dispatch_async(dispatch_get_main_queue()) {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.view.endEditing(true)
                self.tableView.reloadData()
            }
        }
    }
    
    func setupLayout() {
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        let  viewsDict = [
            "searchBar" : searchBar,
            "tableView" : tableView]
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[searchBar]-0-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-60-[searchBar]-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
        
    }
    
    func pressed(sender: UIButton) {
        
        let newVC = WeatherCityViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
               
        if segue!.identifier == "Push" {
            let indexPath = sender as! NSIndexPath
            let MyDetView: WeatherCityViewController = segue!.destinationViewController as! WeatherCityViewController
            MyDetView.cityId = self.arrCity[indexPath.row].id
            
        }
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
          MyDetView.cityId = arrCity[indexPath.row].id
            // self.presentViewController(MyDetView, animated: true,completion: nil)
          navigationController?.pushViewController(MyDetView, animated: true)
            
     }
    
 }

// MARK: - UITableViewDelegate
extension CitySViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
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
        for cityFor in arrCity {
     
       
        if (cityFor.name.hasPrefix(searchText))  {
                filteredArray.append(cityFor)
            }
        }
        
        if(filteredArray.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
        
    }
    
    
}

