//
//  TravelsListTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/4/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit
import CoreData


class TravelsListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    static var travels: [Travel] = [Travel]()
    
    // MARK: - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newFlightButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("flightButtonPressed:"))
        //newFlightButton.tintColor = AppColors.PURPLE_COLOR
        
        let newHotelButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("hotelButtonPressed:"))
        //newHotelButton.tintColor = AppColors.PURPLE_COLOR
        
        self.navigationItem.rightBarButtonItems = [newFlightButton, newHotelButton]
        
        self.title = "TRAVELS"
        
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.backgroundColor = AppColors.PINK

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions Button
    
    func flightButtonPressed(sender: AnyObject?) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newFlightTableViewController: NewFlightTableViewController = storyBoard.instantiateViewControllerWithIdentifier("NewFlightTableViewControllerId") as! NewFlightTableViewController
        
        self.navigationController!.pushViewController(newFlightTableViewController, animated: true)
        
    }
    
    func hotelButtonPressed(sender: AnyObject) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newHotelTableViewController: NewHotelTableViewController = storyBoard.instantiateViewControllerWithIdentifier("NewHotelTableViewControllerId") as! NewHotelTableViewController
        
        self.navigationController!.pushViewController(newHotelTableViewController, animated: true)

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(91.0)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("FlightCellIdentifier", forIndexPath: indexPath) //as! TravelsListTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HotelCellIdentifier", forIndexPath: indexPath)
        

        //let flight = self.travels[indexPath.row]
        //let flight = self.flightList![indexPath.row]
        
        //let flight = self.frc.objectAtIndexPath(indexPath) as! Flight
        
        //cell.dataHourLabel.text = "\(flight.departure_date_hour!)"
        //cell.trackNumberLabel.text = flight.track_number

        //cell.departureAirportLabel.text = flight.departure_airport?.airportName
        //cell.departureCityLabel.text = "\(flight.departure_airport!.cityName!) - \(flight.departure_airport!.stateName!)"
        
        //cell.arrivalAirportLabel.text = flight.arrival_airport?.airportName
        //cell.arrivalCityLabel.text = "\(flight.arrival_airport!.cityName!) - \(flight.arrival_airport!.stateName!)"
        
        //if indexPath.row % 2 == 0 {
        //    cell.backgroundColor = AppColors.LIGHT_GRAY_COLOR
        //} else {
        //    cell.backgroundColor = AppColors.DARK_GRAY_COLOR
        //}

        return cell
    }
    
}
