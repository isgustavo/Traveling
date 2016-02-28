//
//  Flight+CoreDataProperties.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/5/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flight {

    @NSManaged var departure_date_hour: NSDate?
    @NSManaged var track_number: String?
    @NSManaged var attachment_path: String?
    @NSManaged var departure_airport: Airport?
    @NSManaged var arrival_airport: Airport?

}
