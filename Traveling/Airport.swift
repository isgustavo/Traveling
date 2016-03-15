//
//  Airport.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/5/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import Foundation
import CoreData


class Airport: NSManagedObject {

    /*
    var id: Int?
    var cityName: String?
    var airportName: String?
    var airportInitials: String?
    var stateName: String?
    
    
    init(id: Int, cityName: String, airportName: String, airportInitials: String?, stateName: String) {
        self.id = id
        self.cityName = cityName
        self.airportName = airportName
        self.airportInitials = airportInitials
        self.stateName = stateName
        
    }
*/
    
    convenience init()
    {
        // get context
        let context: NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext
        
        // create entity description
        let entityDescription: NSEntityDescription? = NSEntityDescription.entityForName("Airport", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }
}
