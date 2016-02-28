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
    
    var managedObjectContext: NSManagedObjectContext?
    
    dynamic var mResultAirports: NSArray!
    
    var mFlight: Flight?
    
    lazy var mAirportFetchedResults: NSFetchedResultsController = {
        
        let req = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Airport", inManagedObjectContext: self.managedObjectContext!)
        req.entity = entity
        req.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "airport_name", ascending: true)
        req.sortDescriptors = [sortDescriptor]
        
        let afrc = NSFetchedResultsController(fetchRequest: req, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Airports")
        afrc.delegate = self
        
        do {
            
            try afrc.performFetch()
        }catch {
            print("Unresolved error \(error)")
            fatalError("Aborting with unresolved error")
        }
        return afrc
    }()
    
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = self.mAirportFetchedResults.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("airportCellReuseIdentifier", forIndexPath: indexPath)
        
        let object = self.mAirportFetchedResults.objectAtIndexPath(indexPath) as! Airport
        
        // Configure the cell
        cell.textLabel?.text = object.airport_name!
        cell.detailTextLabel?.text = object.city_name! + " - " + object.state_name!
        
        return cell
    }

    //MARK: - Update table view for result search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText = self.mSearchController.searchBar.text!
        
        let aiports = self.mAirportFetchedResults.fetchedObjects as! [Airport]
        
        self.mResultAirports = aiports.filter({ $0.city_name!.uppercaseString.containsString(searchText.uppercaseString) })
        
    }
    
    // MARK: - Departure Airport search table view delegate
    
    func acceptData(data:AnyObject!) {
        
        navigateToArrivalAirportTableViewController(data as! Airport)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        navigateToArrivalAirportTableViewController(self.mAirportFetchedResults.fetchedObjects![indexPath.row] as! Airport)
    }
    
    
    //MARK: - Action buttons
    
    func searchButtonPressed(sender: AnyObject) {
        
        self.presentViewController(self.mSearchController, animated: true, completion: nil)
    }
    
    func navigateToArrivalAirportTableViewController(selected: Airport) { }
    
}
