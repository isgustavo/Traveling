//
//  Flight+CoreDataProperties.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 4/1/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flight {

    @NSManaged var dataHour: NSDate?
    @NSManaged var reservationCode: String?
    @NSManaged var arrivalAirport: Airport?
    @NSManaged var departureAirport: Airport?
    @NSManaged var airline: Airline?

}
