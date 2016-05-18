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

class HistoryViewController: UIViewController {
    
    var tableView: UITableView!
    var arrHistory: [CityGet] = []
    var historyCity: CityGet = CityGet()
    var arrId: [String] = []
    let his = historyMenedger()

    let managedObjectContext =
        (UIApplication.sharedApplication().delegate
            as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "History"
        tableView =  UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CityTableViewCell.self, forCellReuseIdentifier: "CellHistory")
        setupLayout()
        arrHistory = his.historyGetArray()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {        
       
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
    
    func delClick (sender: UIButton) {
        
        let ind = sender.tag
        
        his.historyDel(arrHistory, ind: ind)
        
        arrHistory.removeAtIndex(ind)
        tableView.reloadData()
}
    
}

// MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrHistory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CityTableViewCell  = tableView.dequeueReusableCellWithIdentifier("CellHistory", forIndexPath: indexPath) as! CityTableViewCell
        
            cell.cityLabel.text = arrHistory[indexPath.row].name;
            cell.countryLabel.text = arrHistory[indexPath.row].country;
            cell.idLabel.text = String(arrHistory[indexPath.row].id);
            cell.delButton.addTarget(self, action: #selector(HistoryViewController.delClick(_:)), forControlEvents: .TouchUpInside)
            cell.delButton.tag  = indexPath.row
       
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

