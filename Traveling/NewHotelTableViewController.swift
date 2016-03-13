//
//  NewHotelTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/6/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import UIKit

class NewHotelTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

}
