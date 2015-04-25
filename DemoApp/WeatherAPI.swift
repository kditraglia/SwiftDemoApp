//
//  WeatherAPI.swift
//  DemoApp
//
//  Created by Kevin DiTraglia on 4/25/15.
//  Copyright (c) 2015 Kevin DiTraglia. All rights reserved.
//

import Foundation

class WeatherAPI {
    let baseURLString = "http://api.openweathermap.org/data/2.5"
    let weatherPathFormat = "/weather?lat=%f&lon=%f"
    let forecastPathFormat = "/forecast/daily?lat=%f&lon=%f&cnt=5&mode=json"
    
    var queue: NSOperationQueue = NSOperationQueue()
    var connection: NSURLConnection?
    var delegate: AnyObject?
    var formatter = NSNumberFormatter()
    
    func fetchWeatherWithLatitude(latitude: Double, longitude: Double, completion:((WeatherItem?) -> Void)!) {
        let URLString = baseURLString.stringByAppendingFormat(weatherPathFormat, latitude, longitude)
        
        if let URL = NSURL(string: URLString) {
            let request = NSURLRequest(URL: URL)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if response == nil {
                    completion(nil)
                    return;
                }
                
                var jsonError: NSError? = nil
                if let result: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError) {
                    dispatch_async(dispatch_get_main_queue(), {
                        var temperature: Double = 0
                        var city: String = ""
                        if let root = result as? NSDictionary {
                            if let main = root["main"] as? NSDictionary {
                                if let temp = main["temp"] as? Double {
                                    temperature = temp
                                }
                            }
                            if let c = root["name"] as? String {
                                city = c
                            }
                        }
                        let item = WeatherItem(kelvin: temperature, city: city)
                        completion(item)
                    })
                }
            })
        }
    }
    
    func fetchWeatherForecastWithLatitude(latitude: Double, longitude: Double, completion:(([WeatherItem]?) -> Void)!) {
        let URLString = baseURLString.stringByAppendingFormat(forecastPathFormat, latitude, longitude)
        
        if let URL = NSURL(string: URLString) {
            let request = NSURLRequest(URL: URL)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if response == nil {
                    completion(nil)
                    return;
                }
                
                var jsonError: NSError? = nil
                if let result: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError) {
                    dispatch_async(dispatch_get_main_queue(), {
                        var temperature: Double = 0
                        if let root = result as? NSDictionary {
                            if let list = root["list"] as? NSArray {
                                var forecast = [WeatherItem]()
                                for day in list {
                                    if let temp = day["temp"] as? NSDictionary {
                                        forecast.append(WeatherItem(kelvin: temp["max"] as? Double, city: nil))
                                    }
                                }
                                
                                completion(forecast)
                            }
                        }
                    })
                }
            })
        }
    }
}
