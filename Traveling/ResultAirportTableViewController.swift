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

    var searchResultArray: [Airport] = []
    
    weak var delegate : AirportSearchTableViewDelegate?
    
    // MARK - App lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
        let aiport: Airport = searchResultArray[indexPath.row]
        
        // Configure the cell
        cell.textLabel?.text = aiport.airportName!
        cell.detailTextLabel?.text = aiport.cityName! + " - " + aiport.stateName!
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        delegate?.acceptData(searchResultArray[indexPath.row])
        dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        self.searchResultArray = (object?.valueForKey("mResultAirports"))! as! [Airport]
        self.tableView.reloadData()

    }

}
