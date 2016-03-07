//
//  Flight.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/5/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import Foundation


class Flight {
    
    private var departureAirport: Airport?
    private var dateHour: NSDate!
    private var arrivalAirport: Airport?
    private var number: String?
    
    static let sharedInstance = Flight()
    
    private init() { print("created") }
    
    func getDepartureAirport() -> Airport? {
        return self.departureAirport
    }
    
    func setDepartureAirport(airport: Airport) {
        self.departureAirport = airport
    }
    
    func getDateHour() -> NSDate {
        return self.dateHour
    }
    
    func setDateHour(dateHour: NSDate) {
        self.dateHour = dateHour
    }
    
    func getArrivalAirport() -> Airport? {
        return self.arrivalAirport
    }
    
    func setArrivalAirport(airport: Airport) {
        self.arrivalAirport = airport
    }
    
    func getNumber() -> String? {
        return number
    }
    
    func setNumber(number: String) {
        self.number = number;
    }
    
    

}
