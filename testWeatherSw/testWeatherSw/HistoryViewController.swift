//
//  HistoryViewController.swift
//  testWeatherSw
//
//  Created by FE Team TV on 5/16/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import MBProgressHUD

class HistoryViewController: UIViewController {
    
    var tableView: UITableView!
    var arrHistory: [CityGet] = []
    var historyCity: CityGet = CityGet()
    var arrId: [String] = []
    let his = historyManadger()

    let managedObjectContext =
        (UIApplication.shared.delegate
            as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "History"
        tableView =  UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CellHistory")
        setupLayout()
        arrHistory = his.historyGetArray()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {        
       
    }
    
    func setupLayout() {
        
         view.addSubview(tableView)
        
        let  viewsDict = ["tableView" : tableView]
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
         view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
         view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-60-[tableView]-0-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func delClick (_ sender: UIButton) {
        
        let ind = sender.tag
        
        his.historyDel(arrHistory, ind: ind)
        
        arrHistory.remove(at: ind)
        tableView.reloadData()
}
    
}

// MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CityTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "CellHistory", for: indexPath) as! CityTableViewCell
        
            cell.cityLabel.text = arrHistory[(indexPath as NSIndexPath).row].name;
            cell.countryLabel.text = arrHistory[(indexPath as NSIndexPath).row].country;
            cell.idLabel.text = String(arrHistory[(indexPath as NSIndexPath).row].id);
            cell.delButton.addTarget(self, action: #selector(HistoryViewController.delClick(_:)), for: .touchUpInside)
            cell.delButton.tag  = (indexPath as NSIndexPath).row
       
        return cell
    }
    
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let MyDetView: WeatherCityViewController = WeatherCityViewController()
        MyDetView.cityId = arrHistory[(indexPath as NSIndexPath).row].id
        navigationController?.pushViewController(MyDetView, animated: true)
        
    }
    
}

// MARK: - UITableViewDelegate
extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
}

