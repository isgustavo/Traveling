//
//  Airport.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 11/18/15.
//  Copyright © 2015 isgustavo. All rights reserved.
//

import Foundation

class Airport {
    
    var _ID: Int
    var cityName: String
    var cityInitials: String
    var stateName: String
    var airportName: String
    var airportInitials: String
    
    
    init(id: Int, cityName: String, cityInitials: String, stateName: String, airportName: String, airportInitials: String) {
        
        self._ID = id
        self.cityName = cityName
        self.cityInitials = cityInitials
        self.stateName = stateName
        self.airportName = airportName
        self.airportInitials = airportInitials
        
    }
    
    
}