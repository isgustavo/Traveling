//
//  Airport+CoreDataProperties.swift
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

extension Airport {

    @NSManaged var city_name: String?
    @NSManaged var state_name: String?
    @NSManaged var airport_name: String?

}
