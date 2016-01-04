//
//  Flight+CoreDataProperties.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/14/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flight{

    @NSManaged var departure_airport: NSNumber?
    @NSManaged var departure_date_hour: NSDate?
    @NSManaged var arrival_airport: NSNumber?
    @NSManaged var track_number: String?

}
