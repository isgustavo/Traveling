//
//  NewFlightTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/6/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit
import CoreData

protocol SelectedRowDelegate: class {
    
    func setUpContentOfSet()
    func setOriginalContentOffset()
}

protocol NewFlightDeletage: class {
    
    func selectedAirport(airport: Airport, departure: Bool)
    func selectedDateHour(date: NSDate)
    func setLocatorNumber(locator: String)
    func selectedAirline(airline: Int)
    
}

class NewFlightTableViewController: UITableViewController, SelectedRowDelegate, NewFlightDeletage {
    
    internal let SECTIONS: Int = 1
    internal let ROWS: Int = 6
    
    internal let TOP_SPACE_HEIGHT_CELL = 10.0
    internal let NORMAL_CELL = 85.0
    internal let AIRLANE_CELL = 150.0
    internal let DATE_HOUR_CELL = 242.0
    
    internal let OF_SET_VALUE = 70
    
    var newFlight: Flight? = nil
    
    var departureAirport: Airport?
    var arrivalAirport: Airport?
    var dateHourDeparture: NSDate?
    var locator: String?
    var airline: Int?
    
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
        if self.newFlight != nil {
            self.fillFields()
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fillFields() {
        self.departureAirport = newFlight?.departure_relationship
        self.arrivalAirport = newFlight?.arrival_relationship
        self.dateHourDeparture = newFlight?.data_hour
        self.locator = newFlight?.locator
        self.airline = newFlight?.airline as? Int
    }
    
    private func validate() -> Bool {
        if self.departureAirport != nil && self.arrivalAirport != nil && self.locator != nil {
            return true
        }else {
            return false
        }
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
        }else if indexPath.row == 2 {
            return CGFloat(self.DATE_HOUR_CELL)
        } else if indexPath.row == 5 {
            return CGFloat(AIRLANE_CELL)
        }else {
            return CGFloat(self.NORMAL_CELL)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier("spaceIdentifier", forIndexPath: indexPath)
        case 1:
            let cell =  tableView.dequeueReusableCellWithIdentifier("airportIdentifier", forIndexPath: indexPath) as! AirportTableViewCell
            
            cell.icon.image = UIImage(named: "airplane-57-xxl")
            cell.airport.text = self.departureAirport?.airport_name ?? " "
            
            if let city = self.departureAirport?.city_name {
                cell.city.text = "\(city) - \((self.departureAirport?.state_name)!)"
            }else {
                cell.city.text = " "
            }
            return cell
        case 2:
            let cell =  tableView.dequeueReusableCellWithIdentifier("dateHourReuseIdentifier", forIndexPath: indexPath) as! DateHourTableViewCell
            
            self.dateHourDeparture = self.dateHourDeparture ?? NSDate()
            cell.dateHourDatePicker.date = self.dateHourDeparture!
            
            
            if cell.selectedDelegate == nil {
                cell.selectedDelegate = self
                cell.valueDelegate = self
            }
            
            return cell
        case 3:
            let cell =  tableView.dequeueReusableCellWithIdentifier("airportIdentifier", forIndexPath: indexPath) as! AirportTableViewCell
            
            cell.icon.image = UIImage(named: "airplane-9-xxl")
            cell.airport.text = self.arrivalAirport?.airport_name ?? " "
            
            if let city = self.arrivalAirport?.city_name {
                cell.city.text = "\(city) - \((self.arrivalAirport?.state_name)!)"
            }else {
                cell.city.text = " "
            }
            return cell
        case 4:
            let cell =  tableView.dequeueReusableCellWithIdentifier("locatorIdentifier", forIndexPath: indexPath) as! LocatorTableViewCell
            
            cell.locator.text = self.locator
            
            if cell.selectedDelegate == nil {
                cell.selectedDelegate = self
                cell.valueDelegate = self
            }
            
            return cell
        case 5:
            let cell =  tableView.dequeueReusableCellWithIdentifier("airlineIdentifier", forIndexPath: indexPath) as! AirlineTableViewCell
            
            self.airline = self.airline ?? 0
            cell.airlines?.selectRow(self.airline!, inComponent: 0, animated: true)
            
            if cell.valueDelegate == nil {
                cell.valueDelegate = self
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
            departureAirportTableViewController.delegate = self
            self.navigationController!.pushViewController(departureAirportTableViewController, animated: true)
            
            return
        case 3:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let arrivalAirportTableViewController: ArrivalAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ArrivalAirportTableViewControllerId") as! ArrivalAirportTableViewController
            arrivalAirportTableViewController.delegate = self
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
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
    }
    
    //MARK: - Action buttons
    
    func doneButtonPressed(sender: AnyObject?) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        
        if validate() == false {
            
            showAlertView()
            return
        }
        
        if newFlight == nil {
            self.insert()
        } else {
            //self.update()
        }
        

        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func insert() {
        
        self.newFlight = Flight()
        
        self.newFlight?.departure_relationship = departureAirport
        self.newFlight?.data_hour = self.dateHourDeparture
        self.newFlight?.locator = self.locator
        self.newFlight?.arrival_relationship = self.arrivalAirport
        self.newFlight?.airline = self.airline
        
        FlightDAO.insert(newFlight!)
        
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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.setContentOffset(d, animated: true)
            }
        }
        
        //
    }
    
    // MARK: - NewFlightDeletage
    
    func selectedAirport(airport: Airport, departure: Bool) {
        if departure {
            departureAirport = airport
        } else {
            arrivalAirport = airport
        }
    }
    
    func selectedDateHour(date: NSDate){
        self.dateHourDeparture = date
    }
    
    func setLocatorNumber(locator: String) {
        self.locator = locator
    }
    
    func selectedAirline(airline: Int) {
        self.airline = airline
    }
}
