//
//  LocatorTableViewCell.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/12/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit

class LocatorTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var locator: UITextField!
    
    weak var delegate : SelectedRowDelegate?
    
    @IBAction func selectedToEditing(sender: AnyObject) {

        self.locator.delegate = self
        delegate?.setUpContentOfSet()
        self.setLocatorTextToFlight()
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.locator.resignFirstResponder()
        delegate?.setOriginalContentOffset()
        self.setLocatorTextToFlight()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        delegate?.setOriginalContentOffset()
        self.setLocatorTextToFlight()
        return true
    }
    
    
    func setLocatorTextToFlight(){
        
        if let loc = locator.text {
            Flight.sharedInstance.setNumber(loc)
        }
    }
    
    
}
