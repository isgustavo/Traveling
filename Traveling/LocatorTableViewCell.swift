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
    
    weak var selectedDelegate: SelectedRowDelegate?
    weak var valueDelegate: NewFlightDeletage?
    
    override func awakeFromNib() {
        self.locator.delegate = self
    }
    
    @IBAction func selectedToEditing(sender: AnyObject) {
        
        self.selectedDelegate?.setUpContentOfSet()
    }
    
    //MARK: - UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text
        textField.text = text?.uppercaseString
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.locator.resignFirstResponder()
        self.setLocatorTextToFlight()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        self.setLocatorTextToFlight()
        return true
    }
    
    
    func setLocatorTextToFlight(){
        
        self.selectedDelegate?.setOriginalContentOffset()
        if let loc = locator.text {
            valueDelegate!.setLocatorNumber(loc)
        }
    }
    
    
}
