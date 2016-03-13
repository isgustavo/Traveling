//
//  NewHotelTableViewCell.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/13/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit

class NewHotelTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var icon: UIImageView!

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        self.textField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}
