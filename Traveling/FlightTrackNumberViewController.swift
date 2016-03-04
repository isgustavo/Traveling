//
//  FlightTrackNumberViewController.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 12/16/15.
//  Copyright © 2015 Pé de pano. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import CoreData

class FlightTrackNumberViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var mFlightTrackNumber: UITextField!
    
    var mFlight: Flight?
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(title: "Pronto", style: .Plain, target: self, action: Selector("doneButtonPressed:"))
        self.navigationItem.rightBarButtonItem = doneButton
        
        print("new test here: \(mFlight?.departure_airport?.stateName)")
        print("new test here: \(mFlight?.arrival_airport?.stateName)")
    }

    override func viewWillAppear(animated: Bool) {
        
        mFlightTrackNumber.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func doneButtonPressed(sender: UIBarButtonItem) {
        
        self.mFlight!.track_number = self.mFlightTrackNumber.text
        
        /*
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        if status  == .NotDetermined {
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: nil)
        }
        
        let can = UIImagePickerControllerSourceType.Camera
        let ok = UIImagePickerController.isSourceTypeAvailable(can)
        
        if(!ok) {
            print("no Camera")
            return
        }
        
        let desiredType = kUTTypeImage as NSString as String
        let arr = UIImagePickerController.availableMediaTypesForSourceType(can)
        if arr?.indexOf(desiredType) == nil {
            print("no Camera")
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .Camera
        picker.mediaTypes = [desiredType]
        
        let f = self.view.window!.bounds
        let t = UILabel(frame: f)
        t.textAlignment = .Center
        t.textColor = UIColor.whiteColor()
        t.text = "Algum anexo da reservar?"
        picker.cameraOverlayView = t
        
        picker.delegate = self
        
        self.presentViewController(picker, animated: true, completion: nil)
        */


        saveFlightAndBackToMainList()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        var documentsDirectory: String?
        
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            
            documentsDirectory = paths[0] as? String
            
            let calendar = NSCalendar.currentCalendar()
            let hour = calendar.component(.Hour,fromDate: NSDate())
            
            let path = documentsDirectory! + "/\(hour).jpg"
            let dataImage = UIImageJPEGRepresentation(image, 1.0)
            
            self.mFlight!.attachment_path = path
            NSFileManager.defaultManager().createFileAtPath(path, contents: dataImage, attributes: nil)
            
        }
        
        saveFlightAndBackToMainList()
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {

        saveFlightAndBackToMainList()
    }
    
    
    // MARK - save flight
    
    func saveFlightAndBackToMainList() {
        
        do {
        mFlight?.attachment_path = "path"
        print("test here: \(mFlight?.arrival_airport?.stateName)")
            try managedObjectContext.save()
        } catch {
            
            print(error)
        //    return
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let travelsListTableViewController: TravelsListTableViewController = storyBoard.instantiateViewControllerWithIdentifier("TravelsListTableViewControllerId") as! TravelsListTableViewController

        
        
        travelsListTableViewController.managedObjectContext = self.managedObjectContext
        self.navigationController!.popToRootViewControllerAnimated(true)//  .popToViewController(travelsListTableViewController, animated: true)
        
    }
    

}
