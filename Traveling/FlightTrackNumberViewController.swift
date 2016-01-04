//
//  FlightTrackNumberViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/16/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit

class FlightTrackNumberViewController: UIViewController {

    @IBOutlet weak var mFlightTrackNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController!.navigationItem.title = "Flight Track Number"
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("doneButtonPressed:"))
        self.navigationItem.rightBarButtonItem = doneButton
        
    }

    
    override func viewWillAppear(animated: Bool) {
        
       mFlightTrackNumber.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func doneButtonPressed() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultAirportTableController: FlightTrackNumberViewController = storyBoard.instantiateViewControllerWithIdentifier("FlightTrackNumberViewControllerId") as! FlightTrackNumberViewController
        
        self.navigationController!.pushViewController(resultAirportTableController, animated: true)
        
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
