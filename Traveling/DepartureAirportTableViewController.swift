//
//  DepatureAirportTableViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/15/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit
import CoreData

class DepartureAirportTableViewController: AirportTableViewController, AirportSearchTableViewDelegate {
    
    // MARK - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Prepare search view
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultAirportTableController: ResultAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ResultAirportStoryboardId") as! ResultAirportTableViewController
        resultAirportTableController.delegate = self
        
        self.mSearchController = UISearchController(searchResultsController: resultAirportTableController)
        self.mSearchController.searchBar.placeholder = "Cidade"
        self.mSearchController.searchResultsUpdater = self
        
        //Put scene title
        self.title = "Cidade de Embarque"
        
    }

    override func navigateToArrivalAirportTableViewController(selected: Airport) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let arrivalAirportTableViewController: ArrivalAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ArrivalAirportTableViewControllerId") as! ArrivalAirportTableViewController
        //arrivalAirportTableViewController.managedObjectContext = self.managedObjectContext
        
        print("test state name \(selected.stateName)")
        //self.mFlight!.departure_airport = selected
        //arrivalAirportTableViewController.mFlight = self.mFlight
        self.navigationController!.pushViewController(arrivalAirportTableViewController, animated: true)
    }
    
}