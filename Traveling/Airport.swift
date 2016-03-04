//
//  Airport.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/5/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import Foundation
import CoreData


class Airport: NSObject {

    var cityName: String?
    var airportName: String?
    var airportInitials: String?
    var stateName: String?
    
    
    init(cityName: String, airportName: String, airportInitials: String, stateName: String) {
        
        self.cityName = cityName
        self.airportName = airportName
        self.airportInitials = airportInitials
        self.stateName = stateName
        
    }
}
