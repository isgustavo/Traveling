//
//  AirlinesController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 4/1/16.
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
//

import UIKit

class AirlinesController: UITableViewController {

    var airlines: [Airline]!
    
    var delegate: AirlineDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Airlines"
        
        airlines = AirlineDAO.fetchAll()
        tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airlines.count
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " Choose an airline company. "
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        footer.textLabel?.textColor = UIColor.grayColor()
        footer.textLabel?.font = UIFont (name: "HelveticaNeue-Medium", size: 12)
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("airlineCell", forIndexPath: indexPath)

        cell.textLabel?.text = airlines[indexPath.row].airlineName

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let airline = airlines[indexPath.row]
        
        delegate.airline(airline)
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    

}
