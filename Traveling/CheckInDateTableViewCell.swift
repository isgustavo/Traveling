//
//  CheckInDateTableViewCell.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/13/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit

class CheckInDateTableViewCell: UITableViewCell  {

    @IBOutlet weak var checkIndate: UIDatePicker!
    

    @IBAction func valueChanged(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        
        Hotel.sharedInstance.setCheckInDate(checkIndate.date)
    }

}
