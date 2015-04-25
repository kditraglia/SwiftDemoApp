//
//  ViewController.swift
//  DemoApp
//
//  Created by Kevin DiTraglia on 4/25/15.
//  Copyright (c) 2015 Kevin DiTraglia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cityCellID = "cityCell"
    
    @IBOutlet var tableView: UITableView!
    
    var cities = [CityItem(latitude: 50, longitude: 50, name: "Batys Qazaqstan Oblysy"),
    CityItem(latitude: 5, longitude: 50, name: "Hobyo"),
    CityItem(latitude: 50, longitude: 5, name: "Gedinne"),
    CityItem(latitude: 81, longitude: 7, name: "Longyearbyen"),
    CityItem(latitude: -81, longitude: 7, name: "Antarctica"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cityCellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cityCellID, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = cities[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showWeather", sender: cities[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cityController = segue.destinationViewController as! CityViewController
        cityController.city = sender as? CityItem
    }
}

