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
    
    internal let SECTIONS: Int = 1
    
    var travels: [NSManagedObject] = [NSManagedObject]()
    
    // MARK: - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newFlightButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("flightButtonPressed:"))
        newFlightButton.tintColor = AppColors.PURPLE_COLOR
        
        let newHotelButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("hotelButtonPressed:"))
        newHotelButton.tintColor = AppColors.PURPLE_COLOR
        
        self.navigationItem.rightBarButtonItems = [newFlightButton, newHotelButton]
        
        self.title = "TRAVELS"
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
        //let logoImage:UIImage = UIImage(named: "travels")!
        //self.navigationItem.titleView = UIImageView(image: logoImage)
        
        //self.navigationController!.navigationItem.titleView = UIVIew UIImage(named: "travels")

    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        travels = FlightDAO.fetchAllFlight()
        //l.count
        
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
        return SECTIONS
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if travels[indexPath.row] is Flight {
            return CGFloat(182.0)
        } else {
           return CGFloat(92.0)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if travels[indexPath.row] is Flight {
            let cell = tableView.dequeueReusableCellWithIdentifier("flightCellIdentifier", forIndexPath: indexPath) as! FlightTableViewCell
            let flight = travels[indexPath.row] as! Flight
            
            cell.date.text = "\(flight.data_hour)"
            cell.airport.text = flight.departure_relationship?.airport_name
            cell.city.text = flight.departure_relationship?.city_name
            cell.airline.text = AirlineBrazil.sharedInstance.getAirline(indexPath.row)
            cell.locator.text = flight.locator
            cell.arrivalDate.text = "\(flight.data_hour)"
            cell.arrivalAirport.text = flight.arrival_relationship?.airport_name
            cell.arrivalAirport.text = flight.arrival_relationship?.city_name
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
