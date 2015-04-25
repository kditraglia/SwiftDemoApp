//
//  WeatherItem.swift
//  DemoApp
//
//  Created by Kevin DiTraglia on 4/25/15.
//  Copyright (c) 2015 Kevin DiTraglia. All rights reserved.
//

import Foundation

class WeatherItem {
    let kelvin: Double?
    let city: String?
    
    init(kelvin: Double?, city: String?) {
        self.kelvin = kelvin;
        self.city = city
    }
    
    func fahrenheit() -> Double {
        var fahrenheit: Double = 0.0
        
        if let kelvinValue = kelvin {
            fahrenheit = 1.8 * (kelvinValue - 273.15) + 32.0
        }
        
        return fahrenheit
    }
}