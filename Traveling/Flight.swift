//
//  Flight.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/5/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import Foundation
import CoreData

class Flight: NSManagedObject  {
    
    
    // The designated initializer
    convenience init()
    {
        // get context
        let context: NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext
        
        // create entity description
        let entityDescription: NSEntityDescription? = NSEntityDescription.entityForName("Flight", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }
    
    func valid() -> Bool {

        if departureAirport == nil
            || arrivalAirport == nil
                || reservationCode == nil
                    || airline == nil {
            return false
        } else {
            return true
        }
    }
}
