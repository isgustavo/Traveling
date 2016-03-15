//
//  AirlineTableViewCell.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 3/14/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import UIKit

class AirlineTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var airlines: UIPickerView!
    
    weak var valueDelegate: NewFlightDeletage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.airlines.delegate = self
        self.airlines.dataSource = self
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

    // MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AirlineBrazil.sharedInstance.getAirlines().count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AirlineBrazil.sharedInstance.getAirline(row)
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        
        valueDelegate?.selectedAirline(row)
    }
    
    
}
