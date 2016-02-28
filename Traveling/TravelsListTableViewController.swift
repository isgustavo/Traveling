//
//  TravelsListTableViewController.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 1/4/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import UIKit
import CoreData

/*
final class NewTravelSingleton{
    
    private var context: NSManagedObjectContext
    
    var mDepartureDateHour: NSDate?
    var mDepartureAirport: Airport?
    var mArrivalAirport: Airport?
    var mFlightTrackNumber: String?
    var mAttachmentPath: String?
    
    static var sharedInstance: NewTravelSingleton = NewTravelSingleton()
    
    init(){
      
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        context = appDel.managedObjectContext
        
    }
    
    func save() {
        
        let new = NSEntityDescription.insertNewObjectForEntityForName("Flight", inManagedObjectContext: context)
        
        //new.setValue(mDepartureAirport?._ID, forKey: "departure_airport")
        new.setValue(mDepartureDateHour, forKey: "departure_date_hour")
        //new.setValue(mArrivalAirport?._ID, forKey: "arrival_airport")
        new.setValue(mFlightTrackNumber, forKey: "track_number")
        new.setValue(mAttachmentPath, forKey: "attachment_path")
        
        do {
            try context.save()
            print("saved")
        } catch {
          print("something wrong")
        }
    }
    
    func destroy() {
        
        NewTravelSingleton.sharedInstance = NewTravelSingleton()
    }
    
    private func load() -> Array<Flight>? {
    
        let request = NSFetchRequest(entityName: "Flight")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let aero = result.valueForKey("track_number") as? String {
                        
                        print(aero)
                    }
                }
                
            }

            
        } catch {
            print("Something wrong with load()")
        }
        
        return nil
    }
    
    
}
*/
class TravelsListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    
    lazy var frc: NSFetchedResultsController = {
        
        let req = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Flight", inManagedObjectContext: self.managedObjectContext)
        
        req.entity = entity
        req.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "departure_date_hour", ascending: true)
        req.sortDescriptors = [sortDescriptor]
        
        let afrc = NSFetchedResultsController(fetchRequest: req, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Flights")
        afrc.delegate = self
        
        do {
            
           try afrc.performFetch()
            
        } catch {
            
            print("Unresolved error \(error)")
            fatalError("Aborting with unresolved error")
        }
        
        return afrc
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //save airport's data
        //AirportsBrazilLoad().verifyAirportDataBase(managedObjectContext)
        
        
        //
        let searchButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addButtonPressed:"))
        self.navigationItem.rightBarButtonItem = searchButton
        
        //self.tableView.reloadData()
        
        //flightList = NewTravelSingleton.sharedInstance.load()
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
        
        let sectionInfo = self.frc.sections![section]
        return sectionInfo.numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! TravelsListTableViewCell

        //let flight = self.flightList![indexPath.row]
        
        let flight = self.frc.objectAtIndexPath(indexPath) as! Flight
        
        cell.dataHourLabel.text = "\(flight.departure_date_hour!)"
        cell.trackNumberLabel.text = flight.track_number

        cell.departureAirportLabel.text = flight.departure_airport?.airport_name
        cell.departureCityLabel.text = "\(flight.departure_airport!.city_name!) - \(flight.departure_airport!.state_name!)"
        
        cell.arrivalAirportLabel.text = flight.arrival_airport?.airport_name
        cell.arrivalCityLabel.text = "\(flight.arrival_airport!.city_name!) - \(flight.arrival_airport!.state_name!)"

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

    
    func addButtonPressed(sender: AnyObject?) {
        
        let context = self.frc.managedObjectContext
        let entity = self.frc.fetchRequest.entity!
        
        let mo = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! Flight
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let departureDateHourViewController: DepartureDateHourViewController = storyBoard.instantiateViewControllerWithIdentifier("DepartureDateHourViewControllerId") as! DepartureDateHourViewController
        departureDateHourViewController.managedObjectContext = self.managedObjectContext
        
        departureDateHourViewController.mFlight = mo
        self.navigationController!.pushViewController(departureDateHourViewController, animated: true)
        
    }
}
