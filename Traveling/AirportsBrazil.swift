//
//  AirportsBrazil.swift
//  Traveling
//
//  Created by Gustavo F OLiveira on 11/17/15.
//  Copyright © 2015 HACKATRUCK. All rights reserved.
//

import Foundation
import CoreData

class AirportsBrazil {
    
    private let CITY: String = "CITY"
    private let ID: String = "_id"
    //private let CITY_INITIALS: String = "city_initials"
    private let CITY_NAME: String = "city_name"
    private let STATE_NAME: String = "state_name"
    private let AIRPORT_NAME: String = "airport_name"
    //private let AIRPORT_INITIALS: String = "airport_initials"
    
    static let sharedInstance = AirportsBrazil()
    
    private var airports: [String : [Airport]] = [:]
    private var keys: [String] = []
    
    private init() {
        
        let path: NSString = NSBundle.mainBundle().pathForResource("airportsBrazil", ofType: "json")!
        let data: NSData = try! NSData(contentsOfFile: path as String, options: NSDataReadingOptions.DataReadingMapped)
        
        let dict: NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        for var i = 0 ; i < (dict.valueForKey(CITY) as! NSArray).count; i++ {
            
            let airportResult = (dict.valueForKey(CITY) as! NSArray).objectAtIndex(i)
            
            let cityName:String = airportResult.valueForKey(CITY_NAME) as! String
            let stateName:String = airportResult.valueForKey(STATE_NAME) as! String
            let airportName:String = airportResult.valueForKey(AIRPORT_NAME) as! String
            //let airportInitials:String = airportResult.valueForKey(AIRPORT_INITIALS) as! String
            
            let airport: Airport = Airport(cityName: cityName, airportName: airportName, airportInitials: nil, stateName: stateName)
            
            let cityNameFirstLetter = "\(cityName.characters.first!)"
            
            var listOfAirports: [Airport] = []
            
            if let list = self.airports[cityNameFirstLetter] {
                listOfAirports = list
            }else {
                keys.append(cityNameFirstLetter)
            }
            
            listOfAirports.append(airport)
            
            self.airports[cityNameFirstLetter] = listOfAirports
            
        }

    }
    
    
    func getAirports() -> [String : [Airport]] {
        return self.airports
    }
    
    func getAirport(section: Int, row: Int) -> Airport {
        let key: String = keys[section]
        let aiports = self.airports[key]
        return aiports![row]
    }
    
    func getAllAirports(key key: String) -> [Airport]? {
        return self.airports[key]
    }
    
    func numberOfSections() -> Int {
        return keys.count
    }
    
    func titleOfSection(section section: Int) -> String {
        let key: String = keys[section]
        return key
    }
    
    func numberOfRownInSection(section section: Int) -> Int {
        let key: String = keys[section]
        let list: [Airport] = airports[key]!
        
        return list.count
    }
    
}
