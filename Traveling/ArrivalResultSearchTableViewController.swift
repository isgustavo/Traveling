//
//  ArraivalResultSearchTableViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/16/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit

protocol ArrivalResultSearchTableViewControllerDelegate : class {
    func acceptData(data:AnyObject!)
}

class ArrivalResultSearchTableViewController: UITableViewController {
    
    var mSearchResultArray: Array<Airport>!
    
    weak var delegate : ArrivalResultSearchTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.mSearchResultArray = Array<Airport>()
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
        return mSearchResultArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("airportCellReuseIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = self.mSearchResultArray[indexPath.row].airportName
        cell.detailTextLabel?.text = self.mSearchResultArray[indexPath.row].cityName + " - " + self.mSearchResultArray[indexPath.row].stateName
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let resultAirportTableController: TestViewController = storyBoard.instantiateViewControllerWithIdentifier("TestViewControllerId") as! TestViewController
        
        
        //let navController = UINavigationController(rootViewController: resultAirportTableController) // Creating a navigation controller with resultController at the root of the navigation stack.
        //self.presentViewController(navController, animated:true, completion: nil)
        
        //self.presentViewController(navController, animated: true, completion: nil)
        
        delegate?.acceptData(mSearchResultArray[indexPath.row])
        dismissViewControllerAnimated(false, completion: nil)
        
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
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        self.mSearchResultArray = (object?.valueForKey("mResultAirports"))! as! Array<Airport>
        self.tableView.reloadData()
        
    }
    
}
