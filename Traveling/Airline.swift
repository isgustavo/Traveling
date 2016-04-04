//
//  Airline.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 4/1/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import Foundation
import CoreData


class Airline: NSManagedObject {

    convenience init()
    {
        // get context
        let context: NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext
        
        // create entity description
        let entityDescription: NSEntityDescription? = NSEntityDescription.entityForName("Airline", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }

}
