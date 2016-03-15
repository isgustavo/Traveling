//
//  DepatureAirportTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 12/15/15.
//  Copyright © 2015 HACKATRUCK. All rights reserved.
//

import UIKit
//import CoreData

class DepartureAirportTableViewController: AirportTableViewController, AirportSearchTableViewDelegate {

    // MARK - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Prepare search view
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultAirportTableController: ResultAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ResultAirportStoryboardId") as! ResultAirportTableViewController
        resultAirportTableController.delegate = self
        
        self.mSearchController = UISearchController(searchResultsController: resultAirportTableController)
        self.mSearchController.searchBar.placeholder = "City"
        self.mSearchController.searchResultsUpdater = self
        
        //Put scene title
        self.title = "Depature city"
        
    }

    override func airportSelected(selected: Airport) {
        
        delegate?.selectedAirport(selected, departure: true)
        
        self.navigationController!.popViewControllerAnimated(true)
        
    }
    
}