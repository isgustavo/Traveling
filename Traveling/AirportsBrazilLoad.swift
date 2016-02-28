//
//  AirportsBrazilLoad.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 11/17/15.
//  Copyright © 2015 isgustavo. All rights reserved.
//

import Foundation
import CoreData


class AirportsBrazilLoad {
    
    let CITY: String = "CITY"
    let ID: String = "_id"
    let CITY_INITIALS: String = "city_initials"
    let CITY_NAME: String = "city_name"
    let STATE_NAME: String = "state_name"
    let AIRPORT_NAME: String = "airport_name"
    let AIRPORT_INITIALS: String = "airport_initials"
    
    func verifyAirportDataBase(context: NSManagedObjectContext)  {
        
        let path: NSString = NSBundle.mainBundle().pathForResource("airportsBrazil", ofType: "json")!
        let data: NSData = try! NSData(contentsOfFile: path as String, options: NSDataReadingOptions.DataReadingMapped)
        
        let dict: NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        for var i = 0 ; i < (dict.valueForKey(CITY) as! NSArray).count; i++ {
            
            let airport = (dict.valueForKey(CITY) as! NSArray).objectAtIndex(i)
            
            let cityName:String = airport.valueForKey(CITY_NAME) as! String
            let stateName:String = airport.valueForKey(STATE_NAME) as! String
            let airportName:String = airport.valueForKey(AIRPORT_NAME) as! String
            let airportInitials:String = airport.valueForKey(AIRPORT_INITIALS) as! String

            let new = NSEntityDescription.insertNewObjectForEntityForName("Airport", inManagedObjectContext: context)
            
            new.setValue(airportInitials, forKey: AIRPORT_INITIALS)
            new.setValue(airportName, forKey: AIRPORT_NAME)
            new.setValue(cityName, forKey: CITY_NAME)
            new.setValue(stateName, forKey: STATE_NAME)
            
            do {
                try context.save()
                print("saved \(cityName)")
            } catch {
                print("something wrong")
            }
        }
    }
}