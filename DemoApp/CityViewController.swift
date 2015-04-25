//
//  CityViewController.swift
//  DemoApp
//
//  Created by Kevin DiTraglia on 4/25/15.
//  Copyright (c) 2015 Kevin DiTraglia. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let weatherCellID = "weatherCell"
    let headerID = "headerCell"
    
    var city: CityItem?
    var weather: WeatherItem?
    var forecast: [WeatherItem] = []
    
    let temperatureFormatter = NSNumberFormatter()
    let dateFormatter = NSDateFormatter()
    let dateComponents = NSDateComponents()
    
    let client = WeatherAPI()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: weatherCellID)
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerID)
        
        temperatureFormatter.maximumFractionDigits = 0
        temperatureFormatter.minimumFractionDigits = 0
        dateFormatter.dateFormat = "EEEE"
        
        fetchWeather()
        fetchForecast()
    }
    
    func fetchForecast() {
        self.client.fetchWeatherForecastWithLatitude(city!.latitude!, longitude: city!.longitude!, completion: { items in
            if let weatherItems = items {
                self.forecast = weatherItems
                self.tableView.reloadData()
            }
        })
    }

    func fetchWeather() {
        self.client.fetchWeatherWithLatitude(city!.latitude!, longitude: city!.longitude!, completion: { item in
            if item != nil {
                self.weather = item
            }
            self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(weatherCellID, forIndexPath: indexPath) as! UITableViewCell
        let calendar = NSCalendar.currentCalendar()
        
        dateComponents.day = indexPath.row + 1
        let date = calendar.dateByAddingComponents(dateComponents, toDate: NSDate(), options: NSCalendarOptions())
        let dateString = dateFormatter.stringFromDate(date!)
        let temperate = forecast[indexPath.row].fahrenheit()
        let temperatureString = self.temperatureFormatter.stringFromNumber(temperate)
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        cell.textLabel!.text = "\(dateString):  \(temperatureString!)º"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerID) as! UITableViewHeaderFooterView
        if ((weather) != nil) {
            let temperature = NSNumber(double: weather!.fahrenheit())
            if let temperatureString = self.temperatureFormatter.stringFromNumber(temperature) {
                cell.textLabel.text = "\(temperatureString)º: " + weather!.city!
            }
        }
        return cell
    }
}
