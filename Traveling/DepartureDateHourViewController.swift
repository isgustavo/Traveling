//
//  DepartureDateHourViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/14/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit
import CoreData

class DepartureDateHourViewController: UIViewController {

    //var managedObjectContext: NSManagedObjectContext!
    //@IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var mDateHour: UIDatePicker!
    
    //var mFlight: Flight!
    
    // MARK - App Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(title: "Pronto", style: .Plain, target: self, action: Selector("doneButtonPressed:"))
        self.navigationItem.rightBarButtonItem = doneButton
 
        self.title = "Data/Hora"
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        //let blurView = UIVisualEffectView(effect: blurEffect)
        //blurView.frame.size = CGSize(width: 200, height: 200)
        //blurView.center = view.center
        //view.addSubview(blurView)
        
        // show image
        //self.imageView.image = UIImage(named: "background1")
        
        // create effect
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        // add effect to an effect view
        //let blurView = UIVisualEffectView(effect: blurEffect)
        //blurView.frame = self.view.frame;
        
        // add the effect view to the image view
        //self.imageView.addSubview(blurView)
        
        //[self.imageView addSubview:blurView];
        
        
        //if let dateHour = mFlight.departure_date_hour {
        //    mDateHour.date = dateHour
        //}

    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    // MARK - Action Buttons
    
    func doneButtonPressed(sender: UIBarButtonItem) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let departureAirportTableViewController: DepartureAirportTableViewController = storyBoard.instantiateViewControllerWithIdentifier("DepartureAirportTableViewControllerId") as! DepartureAirportTableViewController
        
        //departureAirportTableViewController.managedObjectContext = appDel.managedObjectContext
        
        //self.mFlight!.departure_date_hour = self.mDateHour.date
        //departureAirportTableViewController.mFlight = self.mFlight
        self.navigationController!.pushViewController(departureAirportTableViewController, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
