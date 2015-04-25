//
//  CityItem.swift
//  DemoApp
//
//  Created by Kevin DiTraglia on 4/25/15.
//  Copyright (c) 2015 Kevin DiTraglia. All rights reserved.
//

import Foundation
class CityItem {
    let latitude: Double?
    let longitude: Double?
    let name: String?
    
    init(latitude: Double?, longitude: Double?, name: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
}