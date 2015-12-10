//
//  AirportTableViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/9/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit

class AirportTableViewController: UITableViewController, UISearchResultsUpdating {

    var mSearchController: UISearchController!
    
    var mAirports: Array<Airport>!
    
    dynamic var mResultAirports: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultAirportTableController: ResultAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("ResultAirportStoryboardId") as! ResultAirportTableViewController
        
        mSearchController = UISearchController(searchResultsController: resultAirportTableController)
        mSearchController.searchBar.placeholder = "City"
        mSearchController.searchResultsUpdater = self
        
        self.addObserver(mSearchController.searchResultsController!, forKeyPath: "mResultAirports", options: .New, context: nil)
        
        self.mAirports = AirportsBrazilLoad().load()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        self.removeObserver(mSearchController.searchResultsController!, forKeyPath: "mResultAirports")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = self.mAirports[indexPath.row].airportName
        cell.detailTextLabel?.text = self.mAirports[indexPath.row].cityName + " - " + self.mAirports[indexPath.row].stateName

        return cell
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
