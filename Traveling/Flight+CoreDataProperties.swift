//
//  Flight+CoreDataProperties.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 3/14/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flight {

    @NSManaged var data_hour: NSDate?
    @NSManaged var locator: String?
    @NSManaged var airline: NSNumber?
    @NSManaged var departure_relationship: Airport?
    @NSManaged var arrival_relationship: Airport?

}
