//
//  AirportTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/5/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import UIKit
import CoreData

class AirportTableViewController : UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    var mSearchController: UISearchController!
    
    dynamic var mResultAirports: NSArray!
    
    // MARK - App lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Put search button
        let searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchButtonPressed:"))
        self.navigationItem.rightBarButtonItem = searchButton
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.addObserver(mSearchController.searchResultsController!, forKeyPath: "mResultAirports", options: .New, context: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        if let observer = mSearchController.searchResultsController {
            self.removeObserver(observer, forKeyPath: "mResultAirports")
            self.mSearchController.searchBar.text = nil
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return AirportsBrazil.sharedInstance.numberOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AirportsBrazil.sharedInstance.numberOfRownInSection(section: section)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return AirportsBrazil.sharedInstance.titleOfSection(section: section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("airportCellReuseIdentifier", forIndexPath: indexPath)
        
        let aiport: Airport = AirportsBrazil.sharedInstance.getAirport(indexPath.section, row: indexPath.row)
        
        // Configure the cell
        cell.textLabel?.text = aiport.airportName!
        cell.detailTextLabel?.text = aiport.cityName! + " - " + aiport.stateName!
        
        return cell
    }

    //MARK: - Update table view for result search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText: String = self.mSearchController.searchBar.text!
        
        if searchText.isEmpty {
            return 
        }
        let airports = AirportsBrazil.sharedInstance.getAllAirports(key: "\(searchText.characters.first!)")
        
        self.mResultAirports = airports?.filter({ $0.cityName!.uppercaseString.containsString(searchText.uppercaseString) })
        
    }
    
    // MARK: - Departure Airport search table view delegate
    
    func acceptData(data:AnyObject!) {
        
        airportSelected(data as! Airport)
        
        //AirportTableViewController(data as! Airport)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //navigateToArrivalAirportTableViewController(self.mAirportFetchedResults.fetchedObjects![indexPath.row] as! Airport)
        
        airportSelected(AirportsBrazil.sharedInstance.getAirport(indexPath.section, row: indexPath.row))
    }
    
    
    //MARK: - Action buttons
    
    func searchButtonPressed(sender: AnyObject) {
        
        self.presentViewController(self.mSearchController, animated: true, completion: nil)
    }
    
    func airportSelected(selected: Airport) { }
    
}
