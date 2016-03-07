//
//  TestTableViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 3/6/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var rows: Int = 0
        
        if section != 0 || section != 5 {
            rows = 1
        }
        
        return rows
    }

    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        var title: String?
        
        if section != 4 {
            title = " "
        }
        
        return title
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
            return CGFloat(230.0)
        } else{
            return CGFloat(44.0)
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch(indexPath.section) {
        case 1:
            let cell =  tableView.dequeueReusableCellWithIdentifier("AirportDepatureReuseIdentifier", forIndexPath: indexPath)
            cell.textLabel?.text = "Departure Airport"
            cell.detailTextLabel?.text = "Location"
            return cell
        case 2:
            let cell =  tableView.dequeueReusableCellWithIdentifier("DateHourReuseIdentifier", forIndexPath: indexPath) as! DateHourTableViewCell
            return cell
        case 3:
            let cell =  tableView.dequeueReusableCellWithIdentifier("ArrivalAirportIdentifier", forIndexPath: indexPath)
            cell.textLabel?.text = "Arrival Airport"
            cell.detailTextLabel?.text = "Location"
            return cell
        case 4:
            let cell =  tableView.dequeueReusableCellWithIdentifier("flightNumberLocatorIdentifier", forIndexPath: indexPath)
            cell.textLabel?.text = "Flight Number Locator"
            cell.detailTextLabel?.text = "YHNQUZ"
            return cell
        default:
            let cell =  tableView.dequeueReusableCellWithIdentifier("AirportDepatureReuseIdentifier", forIndexPath: indexPath)
            return cell
        }
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

}
