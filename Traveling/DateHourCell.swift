//
//  DateHourCell.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/31/16.
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

import UIKit

class DateHourCell: UITableViewCell {


    @IBOutlet weak var dateHour: UILabel!

    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter = NSDateFormatter()
    
    var delegate: DateAndHourDelegate!
    
    override func awakeFromNib() {
        
        
        self.datePicker.locale = NSLocale(localeIdentifier: "en_GB")
        self.dateFormatter.dateFormat = "EE MMMM dd,  HH:mm"
        
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        
        let date: NSDate = self.datePicker.date
        
        self.dateHour.text = self.dateFormatter.stringFromDate(date)
        self.delegate.dateAndHour(date)
    }
    
}
