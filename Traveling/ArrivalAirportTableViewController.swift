//
//  ArrivalAirportTableViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/16/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit

class ArrivalAirportTableViewController: AirportTableViewController, AirportSearchTableViewDelegate {
    
    // MARK - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultAirportTableController: ResultAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ResultAirportStoryboardId") as! ResultAirportTableViewController
        resultAirportTableController.delegate = self
        
        self.mSearchController = UISearchController(searchResultsController: resultAirportTableController)
        self.mSearchController.searchBar.placeholder = "City"
        self.mSearchController.searchResultsUpdater = self
        
        //Put scene title
        self.title = "Arrival city"
        
    }

    override func airportSelected(selected: Airport) {
        
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let flightTrackNumberViewController: FlightTrackNumberViewController = storyBoard.instantiateViewControllerWithIdentifier("FlightTrackNumberViewControllerId") as! FlightTrackNumberViewController
        //flightTrackNumberViewController.managedObjectContext = self.managedObjectContext
        
        //self.mFlight!.arrival_airport = selected
        //flightTrackNumberViewController.mFlight = self.mFlight
        //self.navigationController!.pushViewController(flightTrackNumberViewController, animated: true)
        Flight.sharedInstance.setArrivalAirport(selected)
        self.navigationController!.popViewControllerAnimated(true)
        //dismissViewControllerAnimated(false, completion: nil)
    }
    
}
