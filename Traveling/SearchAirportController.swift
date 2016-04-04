//
//  SearchAirportController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/29/16.
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

import UIKit

class SearchAirportController: UITableViewController {
    
    var departure: Bool?
    
    private var searchedAirport: [Airport]?
    private var airports: [Airport]?
    
    var delegate: AirportSearchTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.airports = AirportDAO.fetchAll()
        self.searchedAirport = self.airports
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedAirport!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("airportCell", forIndexPath: indexPath)

        cell.textLabel?.text = searchedAirport![indexPath.row].airport_name
        cell.detailTextLabel?.text = searchedAirport![indexPath.row].city_name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let airport = searchedAirport![indexPath.row]
        
        delegate.airport(airport, toDeparture: departure!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: - UI Search Controller Observer
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let searchCity: String = (object?.valueForKey("searchCity"))! as! String
        
        if searchCity.isEmpty {
            return
        }
            
        self.searchedAirport = airports?.filter({ $0.city_name!.uppercaseString.containsString(searchCity.uppercaseString) })
        self.tableView.reloadData()
    }
    

}
