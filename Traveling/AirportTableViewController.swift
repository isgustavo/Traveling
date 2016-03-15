//
//  AirportTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/5/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit
import CoreData

class AirportTableViewController : UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    var mSearchController: UISearchController!
    
    dynamic var mResultAirports: NSArray!
    
    weak var delegate: NewFlightDeletage?
    
    var airportList: [Airport]?
    
    // MARK - App lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Put search button
        let searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchButtonPressed:"))
        self.navigationItem.rightBarButtonItem = searchButton
        
        airportList = AirportDAO.fetchAll()
        
        
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
        return 1//AirportsBrazil.sharedInstance.numberOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return AirportsBrazil.sharedInstance.numberOfRownInSection(section: section)
        return (airportList?.count)!
    }
    
    //override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //    return AirportsBrazil.sharedInstance.titleOfSection(section: section)
    //}
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("airportCellReuseIdentifier", forIndexPath: indexPath)
        
        //let aiport: Airport = AirportsBrazil.sharedInstance.getAirport(indexPath.section, row: indexPath.row)
        let airport = airportList![indexPath.row]
        
        // Configure the cell
        cell.textLabel?.text = airport.airport_name
        cell.detailTextLabel?.text = airport.city_name! + " - " + airport.state_name!
        
        return cell
    }

    //MARK: - Update table view for result search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText: String = self.mSearchController.searchBar.text!
        
        if searchText.isEmpty {
            return 
        }
        //let airports = AirportsBrazil.sharedInstance.getAllAirports(key: "\(searchText.characters.first!)")
        
        self.mResultAirports = airportList?.filter({ $0.city_name!.uppercaseString.containsString(searchText.uppercaseString) })
        
    }
    
    // MARK: - Departure Airport search table view delegate
    
    func acceptData(data:AnyObject!) {
        
        airportSelected(data as! Airport)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let airport = airportList![indexPath.row]
        //airportSelected(AirportsBrazil.sharedInstance.getAirport(indexPath.section, row: indexPath.row))
        airportSelected(airport)
    }
    
    
    //MARK: - Action buttons
    
    func searchButtonPressed(sender: AnyObject) {
        
        self.presentViewController(self.mSearchController, animated: true, completion: nil)
    }
    
    func airportSelected(selected: Airport) { }
    
}
