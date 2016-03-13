//
//  NewFlightTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/6/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit

protocol SelectedRowDelegate : class {
    
    func setUpContentOfSet()
    func setOriginalContentOffset()
}

class NewFlightTableViewController: UITableViewController, SelectedRowDelegate {
    
    internal let SECTIONS: Int = 1
    internal let ROWS: Int = 5
    
    internal let TOP_SPACE_HEIGHT_CELL = 10.0
    internal let NORMAL_CELL = 79.0
    internal let DATE_HOUR_CELL = 242.0
    
    internal let OF_SET_VALUE = 70
    
    // MARK: - App Lifecycle
    
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
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.SECTIONS
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ROWS
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(TOP_SPACE_HEIGHT_CELL)
        }else if indexPath.row != 2 {
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
            let cell =  tableView.dequeueReusableCellWithIdentifier("airportIdentifier", forIndexPath: indexPath) as! AirportTableViewCell
            
            cell.icon.image = UIImage(named: "airplaneUp")
            cell.airport.text = Flight.sharedInstance.getDepartureAirport()?.airportName ?? " "
            
            if let city = Flight.sharedInstance.getDepartureAirport()?.cityName {
                cell.city.text = "\(city) - \((Flight.sharedInstance.getDepartureAirport()?.stateName)!)"
            }else {
                cell.city.text = " "
            }
            return cell
        case 2:
            let cell =  tableView.dequeueReusableCellWithIdentifier("dateHourReuseIdentifier", forIndexPath: indexPath) as! DateHourTableViewCell
            
            cell.dateHourDatePicker.date = Flight.sharedInstance.getDateHour()
            
            if let _ = cell.delegate {
            }else {
                cell.delegate = self
            }
            
            return cell
        case 3:
            let cell =  tableView.dequeueReusableCellWithIdentifier("airportIdentifier", forIndexPath: indexPath) as! AirportTableViewCell
            cell.icon.image = UIImage(named: "airplaneDown")
            cell.airport.text = Flight.sharedInstance.getArrivalAirport()?.airportName ?? " "
            if let city = Flight.sharedInstance.getArrivalAirport()?.cityName {
                cell.city.text = "\(city) - \((Flight.sharedInstance.getArrivalAirport()?.stateName)!)"
            }else {
                cell.city.text = " "
            }
            return cell
        case 4:
            let cell =  tableView.dequeueReusableCellWithIdentifier("LocatorIdentifier", forIndexPath: indexPath) as! LocatorTableViewCell
            
            cell.locator.text = Flight.sharedInstance.getNumber()
            if let _ = cell.delegate {
            }else {
                cell.delegate = self
            }

            return cell
        default:
            let cell =  tableView.dequeueReusableCellWithIdentifier("AirportDepatureReuseIdentifier", forIndexPath: indexPath)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row) {
        case 1:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let departureAirportTableViewController: DepartureAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("DepartureAirportTableViewControllerId") as!DepartureAirportTableViewController
            self.navigationController!.pushViewController(departureAirportTableViewController, animated: true)
            
            return
        case 3:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let arrivalAirportTableViewController: ArrivalAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ArrivalAirportTableViewControllerId") as! ArrivalAirportTableViewController
            self.navigationController!.pushViewController(arrivalAirportTableViewController, animated: true)
            
            return
        case 4:
            setUpContentOfSet()
            let cell: LocatorTableViewCell = (tableView.cellForRowAtIndexPath(indexPath) as? LocatorTableViewCell)!
            cell.locator.becomeFirstResponder()
            
            return
        default:
            return
        }
        
    }
    
    //MARK: - Action buttons
    
    func doneButtonPressed(sender: AnyObject?) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
                
        let air = Flight.sharedInstance
        
        if air.completed() == false {
            
            showAlertView()
        }
                
        TravelsListTableViewController.travels.append(air)

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
    
    // MARK: - Selected Row Delegate
    func setOriginalContentOffset() {
        let d = CGPoint(x: 0, y: -OF_SET_VALUE)
        self.tableView.setContentOffset(d, animated: true)

    }
    
    func setUpContentOfSet() {
        let d = CGPoint(x: 0, y: OF_SET_VALUE)
        self.tableView.setContentOffset(d, animated: true)
    }
    
}
