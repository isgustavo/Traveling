//
//  AddHotelController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 4/3/16.
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

class AddHotelController: UITableViewController, UITextFieldDelegate, DateAndHourDelegate {

    private var hotel: Hotel!
    
    var update: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //right button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = doneButton

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        if !self.update {
            self.hotel = Hotel()
        }
        
        self.title = "NEW HOTEL"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Action buttons
    
    func doneButtonPressed(sender: AnyObject?) {
        
        hotel.name = textIn(section: 0, row: 0)
        hotel.address = textIn(section: 0, row: 1)
        hotel.phone = textIn(section: 1, row: 0)
        
        if self.hotel.valid() == false {
            showAlertView()
        } else {
            if self.update == false {
                HotelDAO.insert(self.hotel)
            } else {
                HotelDAO.update(self.hotel)
            }
            
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    func showAlertView() {
        
        // create the alert
        let alert = UIAlertController(title: "Done?", message: "You must fill in all fields before the Done button.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    private let titleForHeadersAndFooter: [(String,String?)] = [("Hotel and address", " "), ("Phone", " "), ("Check-in date", " ")]
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return titleForHeadersAndFooter.count + 8
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        switch section {
        case 0:
            rows = 2
        case 1...2:
            rows = 1
        default:
            rows = 0
        }
        return rows
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var heightForRow: CGFloat = CGFloat(44.0)
        
        if indexPath.section == 2 {
            heightForRow = CGFloat(200.0)
        }
        return heightForRow
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if titleForHeadersAndFooter.count > section {
            return titleForHeadersAndFooter[section].0.uppercaseString
        } else {
            return " "
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.grayColor()
        header.textLabel?.font = UIFont (name: "HelveticaNeue-Medium", size: 11)
        
    }

    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("rightTextCell", forIndexPath: indexPath) as! RightTextCell
                
                if let c = cell as? RightTextCell {
                    c.txt.placeholder = " Hotel's name "
                    c.txt.delegate = self
                }
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("rightTextCell", forIndexPath: indexPath) as! RightTextCell
                
                if let c = cell as? RightTextCell {
                    c.txt.placeholder = " Address "
                    c.txt.delegate = self
                }
            default: break
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("rightTextCell", forIndexPath: indexPath) as! RightTextCell
            
            if let c = cell as? RightTextCell {
                c.txt.placeholder = " Number "
                c.txt.delegate = self
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("dateHourCell", forIndexPath: indexPath) as! DateHourCell
            
            if let c = cell as? DateHourCell {
                c.delegate = self
                
                if let _ = self.hotel.checkIInDate {
                    
                }else {
                    self.hotel.checkIInDate = NSDate()
                }
                
                c.dateHour.text = c.dateFormatter.stringFromDate(self.hotel.checkIInDate!)
                c.datePicker.date = self.hotel.checkIInDate!
            }
            
            
        default: break
        }

        return cell
    }
    
    // MARK: - Date Hour Delegate
    
    func dateAndHour(selected: NSDate) {
        self.hotel.checkIInDate = selected
    }
    

    //MARK: - UIText Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return false
    }
    
    
    func textIn(section section: Int, row: Int) -> String? {
        
        let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: section)
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if let c = cell as? RightTextCell {
            if c.txt != nil && c.txt.text != " " {
                return c.txt.text
            }
        }
        
        return nil
        
    }


}
