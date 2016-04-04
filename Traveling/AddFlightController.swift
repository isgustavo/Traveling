 //
//   AddFlightController.swift
//   Traveling
//
//   Created by Gustavo F Oliveira on 3/29/16.
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

protocol AirportSearchTableViewDelegate: class {
    func airport(selected: Airport, toDeparture departure: Bool)
}

protocol AirlineDelegate: class {
    func airline(selected: Airline)
}

protocol DateAndHourDelegate: class {
    func dateAndHour(selected: NSDate)
}

class AddFlightController: UITableViewController, AirportSearchTableViewDelegate, AirlineDelegate, UISearchResultsUpdating, UITextFieldDelegate, DateAndHourDelegate {
    
    private var searchController: UISearchController!
    
    dynamic var searchCity: String!
    
    private var flight: Flight!
    
    var update: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //right button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(AddFlightController.doneButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.searchController = ({
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let searchAirportController = storyBoard.instantiateViewControllerWithIdentifier("SearchAirportControllerId") as! SearchAirportController
            searchAirportController.delegate = self
            
            let controller = UISearchController(searchResultsController: searchAirportController)
            controller.searchBar.barTintColor = AppColors.PURPLE_COLOR
            controller.searchBar.tintColor = UIColor.whiteColor()
            controller.searchBar.placeholder = "Airport's city"
            controller.searchResultsUpdater = self
            
            return controller
        }) ()
        
        if !update {
            self.flight = Flight()
        }
        
        self.title = "NEW FLIGHT"

    }

    override func viewDidAppear(animated: Bool) {
        self.addObserver(self.searchController.searchResultsController!, forKeyPath: "searchCity", options: .New, context: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        if let observer = self.searchController.searchResultsController {
            self.removeObserver(observer, forKeyPath: "searchCity")
            self.searchController.searchBar.text = nil
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Action buttons
    
    func doneButtonPressed(sender: AnyObject?) {
        UIApplication.sharedApplication().sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, forEvent:nil)
        self.cellIn(row: 2, hidden: false)
        
        if self.flight.valid() == false {
            showAlertView()
        } else {
            if self.update == false {
                FlightDAO.insert(self.flight)
            } else {
                FlightDAO.update(self.flight)
            }
            
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    func showAlertView() {
        
        // create the alert
        let alert = UIAlertController(title: "Done?", message: "You must fill in all fields before the Done button.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    private let titleForHeadersAndFooter: [(String,String?)] = [("City and time of departure", nil), ("Arrive to", " "), ("Reservation code", " The reservation code is a combination of six characters, including letters and numbers. "), ("Airline", " ")]
    
    // MARK: - Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.titleForHeadersAndFooter.count + 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        switch section {
        case 0:
            rows = 2
        case 1...3:
            rows = 1
        default:
            rows = 0
        }
        return rows
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if titleForHeadersAndFooter.count > section {
            return titleForHeadersAndFooter[section].0.uppercaseString
        } else {
            return " "
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.grayColor()
        header.textLabel?.font = UIFont (name: "HelveticaNeue-Medium", size: 11)

    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if titleForHeadersAndFooter.count > section {
            return titleForHeadersAndFooter[section].1
        } else {
            return " "
        }
    
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        footer.textLabel?.textColor = UIColor.grayColor()
        footer.textLabel?.font = UIFont (name: "HelveticaNeue-Medium", size: 9)
        footer.textLabel?.numberOfLines = 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var heightForRow: CGFloat = CGFloat(44.0)
        
        if indexPath.section == 0 && indexPath.row == 1 {
            heightForRow = CGFloat(200.0)
        }
        return heightForRow
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("normalCell", forIndexPath: indexPath)
                
                cell.textLabel?.text = " "
                if let text = self.flight.departureAirport?.airport_name {
                    cell.detailTextLabel?.text = text
                    cell.detailTextLabel?.textColor = UIColor.blackColor()
                } else {
                    cell.detailTextLabel?.text = "Location"
                    cell.detailTextLabel?.textColor = UIColor.lightGrayColor()
                }
                
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("dateCell", forIndexPath: indexPath) as! DateHourCell
                
                if let c = cell as? DateHourCell {
                    c.delegate = self
                    
                    if let _ = self.flight.dataHour {
                        
                    }else {
                        self.flight.dataHour = NSDate()
                    }
                    
                    c.dateHour.text = c.dateFormatter.stringFromDate(self.flight.dataHour!)
                    c.datePicker.date = self.flight.dataHour!
                }
            default: break
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("normalCell", forIndexPath: indexPath)
            
            cell.textLabel?.text = " "
            if let text = self.flight.arrivalAirport?.airport_name {
                cell.detailTextLabel?.text = text
                cell.detailTextLabel?.textColor = UIColor.blackColor()
            } else {
                cell.detailTextLabel?.text = "Location"
                cell.detailTextLabel?.textColor = UIColor.lightGrayColor()
            }
            
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("reservationCodeCell", forIndexPath: indexPath) as! ReservationCodeCell
            
            if let c = cell as? ReservationCodeCell {
                c.reservationCode.delegate = self
            }
            
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("normalCell", forIndexPath: indexPath)
            
            cell.textLabel?.text = " "
            cell.detailTextLabel?.text = flight.airline?.airlineName
            
            
        default: return UITableViewCell()
        }
        
        return cell

    }
    
    private var datePicker: UIDatePicker!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.cellIn(row: 2, hidden: false)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case 0:
                    let searchAirportController = self.searchController.searchResultsController as! SearchAirportController
                    searchAirportController.departure = true
                
                    self.searchController.searchBar.text = nil
                    self.presentViewController(self.searchController, animated: true, completion: nil)
            default: break
            }
        case 1:
            let searchAirportController = self.searchController.searchResultsController as! SearchAirportController
            searchAirportController.departure = false
            
            self.searchController.searchBar.text = nil
            self.presentViewController(self.searchController, animated: true, completion: nil)
        case 3:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let airlineController: AirlinesController = storyBoard.instantiateViewControllerWithIdentifier("AirlinesControllerId") as! AirlinesController
            airlineController.delegate = self
            self.navigationController!.pushViewController(airlineController, animated: true)
            
        default: break
        }
    }
    
    //MARK: - Update Table View for Result Search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.searchCity = searchController.searchBar.text!
        
    }
    
    // MARK: - Airport Search Table View Delegate
    
    func airport(selected : Airport, toDeparture departure: Bool) {
        
        if departure {
            self.flight.departureAirport = selected
        } else {
            self.flight.arrivalAirport = selected
        }
        
        self.tableView.reloadData()
       
    }
    
    // MARK: - Airline Selected Delegate
    
    func airline(selected: Airline) {
        self.flight.airline = selected
        self.tableView.reloadData()
    }
    
    // MARK: - Date Hour Delegate
    
    func dateAndHour(selected: NSDate) {
        self.flight.dataHour = selected
    }
    
    //MARK: - UIText Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        self.cellIn(row: 2, hidden: false)
        
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.cellIn(row: 2, hidden: true)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.flight.reservationCode = textField.text
        
        return true
    }
    
    func cellIn(row row: Int, hidden: Bool) {
        let footer: UITableViewHeaderFooterView =  tableView.footerViewForSection(row)!
        footer.hidden = hidden
    }

}

