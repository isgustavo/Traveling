//
//  Hotel.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 3/13/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import Foundation

class Hotel {

    private var name: String?
    private var address: String?
    private var phone: String?
    private var checkInDate: NSDate?
    
    static let sharedInstance = Hotel()
    
    private init() {
        self.checkInDate = NSDate()
    }
    
    func getName() -> String? {
        return self.name
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getAddress() -> String? {
        return self.address
    }
    
    func setAddress(address: String) {
        self.address = address
    }
    
    func getPhone() -> String? {
        return self.phone
    }
    
    func setPhone(phone: String) {
        self.phone = phone
    }
    
    func getCheckInDate() -> NSDate? {
        return self.checkInDate
    }
    
    func setCheckInDate(date: NSDate) {
        self.checkInDate = date
    }
    
    func completed() -> Bool{
        if self.name != nil && self.name != ""
            && self.address != nil && self.address != ""
            && self.phone != nil  && self.phone != "" {
            return true
        }else {
            return false
        }
    }

    
    
    
}
