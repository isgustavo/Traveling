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

    weak var delegate : SelectedRowDelegate?
    
    @IBAction func dataHourChanged(sender: AnyObject) {
        dateHourDatePicker.becomeFirstResponder()
        
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        delegate?.setOriginalContentOffset()

        let date: NSDate = dateHourDatePicker.date
        Flight.sharedInstance.setDateHour(date)
    }
}
