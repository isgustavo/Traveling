//
//  DateHourTableViewCell.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 3/6/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import UIKit

class DateHourTableViewCell: UITableViewCell {

    @IBOutlet weak var dateHourDatePicker: UIDatePicker!

    weak var selectedDelegate: SelectedRowDelegate?
    weak var valueDelegate: NewFlightDeletage?
    
    @IBAction func dataHourChanged(sender: AnyObject) {
        dateHourDatePicker.becomeFirstResponder()
        
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        selectedDelegate?.setOriginalContentOffset()

        let date: NSDate = dateHourDatePicker.date
        valueDelegate?.selectedDateHour(date)
    
    }
}
