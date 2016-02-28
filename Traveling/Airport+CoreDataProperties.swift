//
//  Airport+CoreDataProperties.swift
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

extension Airport {

    @NSManaged var city_name: String?
    @NSManaged var airport_name: String?
    @NSManaged var airport_initials: String?
    @NSManaged var state_name: String?

}
