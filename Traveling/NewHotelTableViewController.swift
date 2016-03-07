//
//  NewHotelTableViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 3/6/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import UIKit

class NewHotelTableViewController: UITableViewController {

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
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        
        if section == 0 {
            return 0
        } else if section == 1 {
            return 5
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        var title: String?
        
        if section == 0 {
            title = " "
        }
        
        return " "
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section > 1 {
            return CGFloat(230.0)
        } else {
            return CGFloat(44.0)
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewHotelIdentifier", forIndexPath: indexPath) as! NewHotelTableViewCell

        // Configure the cell...
        if indexPath.section == 1 {
            switch(indexPath.row) {
            case 0:
                cell.mText.placeholder = "Hotel's name"
                cell.mText.hidden = false
            case 1:
                cell.mText.placeholder = "Hotel's andress"
                cell.mText.hidden = false
            case 2:
                cell.mText.placeholder = "Hotel's district"
                cell.mText.hidden = false
            case 3:
                cell.mText.placeholder = "Hotel's city"
                cell.mText.hidden = false
            case 4:
                cell.mText.placeholder = "Hotel's phone number"
                cell.mText.hidden = false
            default:
                cell.mText.hidden = true
                cell.mDate.hidden = true
            }
        }else if indexPath.section == 2 {
            cell.mDate.hidden = false
        }else if indexPath.section == 3 {
            cell.mDate.hidden = false
        }
        
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

}
