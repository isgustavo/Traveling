//
//  NewHotelTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/6/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit

class NewHotelTableViewController: UITableViewController {
    
    internal let SECTIONS: Int = 1
    internal let ROWS: Int = 5
    
    internal let TOP_SPACE_HEIGHT_CELL = 10.0
    internal let NORMAL_CELL = 79.0
    internal let DATE_HOUR_CELL = 242.0

    // MARK: - App cyclelife
    override func viewDidLoad() {
        super.viewDidLoad()

        //right button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("doneButtonPressed:"))
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.tintColor = AppColors.PURPLE_COLOR
        
        //title
        self.title = "NEW FLIGHT"
        self.navigationController?.navigationBar.tintColor = AppColors.PURPLE_COLOR
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action Buttons
    
    func doneButtonPressed(sender: AnyObject?) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        
        let hotel = Hotel.sharedInstance
        
        let firstCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! NewHotelTableViewCell
        let secondCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! NewHotelTableViewCell
        let thirdCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! NewHotelTableViewCell
        
        hotel.setName((firstCell.textField?.text)!)
        hotel.setAddress((secondCell.textField?.text)!)
        hotel.setPhone((thirdCell.textField?.text)!)
        if hotel.completed() == false {
            
            showAlertView()
        }
        
        //TravelsListTableViewController.travels.append(hotel)
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func showAlertView() {
        
        // create the alert
        let alert = UIAlertController(title: "Done?", message: "You must fill in all fields before the Done button.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SECTIONS
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ROWS
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return CGFloat(TOP_SPACE_HEIGHT_CELL)
        }else if indexPath.row != 4 {
            return CGFloat(self.NORMAL_CELL)
        } else {
            return CGFloat(self.DATE_HOUR_CELL)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier("spaceIdentifier", forIndexPath: indexPath)
        case 1:
            let cell =  tableView.dequeueReusableCellWithIdentifier("hoteldentifier", forIndexPath: indexPath) as! NewHotelTableViewCell
            
            cell.icon.image = UIImage(named: "hotel")
            cell.title.text = "HOTEL"
            cell.textField.text = Hotel.sharedInstance.getName() ?? " "

            return cell
        case 2:
            let cell =  tableView.dequeueReusableCellWithIdentifier("hoteldentifier", forIndexPath: indexPath) as! NewHotelTableViewCell
            
            cell.icon.image = UIImage(named: "location")
            cell.title.text = "ADDRESS"
            cell.textField.text = Hotel.sharedInstance.getAddress() ?? " "
            
            return cell
        case 3:
            let cell =  tableView.dequeueReusableCellWithIdentifier("hoteldentifier", forIndexPath: indexPath) as! NewHotelTableViewCell
            
            cell.icon.image = UIImage(named: "phone")
            cell.title.text = "PHONE"
            cell.textField.text = Hotel.sharedInstance.getPhone() ?? " "

            return cell
        case 4:
            let cell =  tableView.dequeueReusableCellWithIdentifier("dateHourIdentifier", forIndexPath: indexPath) as! CheckInDateTableViewCell

            cell.checkIndate.date = Hotel.sharedInstance.getCheckInDate()!
            
            return cell
        default:
            let cell =  tableView.dequeueReusableCellWithIdentifier("spaceIdentifier", forIndexPath: indexPath)
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row) {
        case 1...3:
            let cell: NewHotelTableViewCell = (tableView.cellForRowAtIndexPath(indexPath) as? NewHotelTableViewCell)!
            cell.textField.becomeFirstResponder()
            
            return
        default:
            return
        }
        
    }

}
