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
        
        delegate?.selectedAirport(selected, departure: false)
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
}
