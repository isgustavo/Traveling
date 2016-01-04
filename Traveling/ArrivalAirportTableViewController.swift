//
//  ArrivalAirportTableViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/16/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit

class ArrivalAirportTableViewController: UITableViewController, UISearchResultsUpdating, ArrivalResultSearchTableViewControllerDelegate  {
    
    var mSearchController: UISearchController!
    
    var mAirports: Array<Airport>!
    
    dynamic var mResultAirports: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultAirportTableController: ArrivalResultSearchTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ArrivalAirportResultStoryboardId") as! ArrivalResultSearchTableViewController
        resultAirportTableController.delegate = self
        
        mSearchController = UISearchController(searchResultsController: resultAirportTableController)
        mSearchController.searchBar.placeholder = "City"
        mSearchController.searchResultsUpdater = self
        
        self.navigationController?.navigationItem.title = "Arrival Airport"
        
        let search = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchButtonPressed:"))
        self.navigationItem.rightBarButtonItem = search
        
        self.mAirports = AirportsBrazilLoad().load()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.addObserver(mSearchController.searchResultsController!, forKeyPath: "mResultAirports", options: .New, context: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        if let observer = mSearchController.searchResultsController {
            self.removeObserver(observer, forKeyPath: "mResultAirports")
            mSearchController.searchBar.text = nil
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func acceptData(data:AnyObject!) {
        
        navigateToArrivalAirportTableViewController()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.mAirports.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("airportCellReuseIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = self.mAirports[indexPath.row].airportName
        cell.detailTextLabel?.text = self.mAirports[indexPath.row].cityName + " - " + self.mAirports[indexPath.row].stateName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        navigateToArrivalAirportTableViewController()
    }
    
    func navigateToArrivalAirportTableViewController() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultAirportTableController: FlightTrackNumberViewController = storyBoard.instantiateViewControllerWithIdentifier("FlightTrackNumberViewControllerId") as! FlightTrackNumberViewController
        
        self.navigationController!.pushViewController(resultAirportTableController, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText = self.mSearchController.searchBar.text!
        
        self.mResultAirports = self.mAirports.filter({ $0.cityName.uppercaseString.containsString(searchText.uppercaseString) })
        
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        
        self.presentViewController(self.mSearchController, animated: true, completion: nil)
    }
    
    
}
