//
//  ResultAirportTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 12/9/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit

protocol AirportSearchTableViewDelegate : class {
    func acceptData(data:AnyObject!)
}

class ResultAirportTableViewController: UITableViewController {

    var mSearchResultArray: Array<Airport>!
    
    weak var delegate : AirportSearchTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mSearchResultArray = Array<Airport>()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mSearchResultArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    

        // Configure the cell
        cell.textLabel?.text = self.mSearchResultArray[indexPath.row].airport_name
        cell.detailTextLabel?.text = self.mSearchResultArray[indexPath.row].city_name! + " - " + self.mSearchResultArray[indexPath.row].state_name!
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        delegate?.acceptData(mSearchResultArray[indexPath.row])
        dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        self.mSearchResultArray = (object?.valueForKey("mResultAirports"))! as! Array<Airport>
        self.tableView.reloadData()

    }

}
