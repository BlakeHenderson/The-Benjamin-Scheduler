//
//  AddNewsController.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 1/6/16.
//  Copyright © 2016 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class AddNewsController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var titleField: UITextField!
    var statusCode:Int = 0
    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var agreeSwitch: UISwitch!
    
    var titleFinal = ""
    var messageFinal = ""
    
    var noInfoAlert = UIAlertView(title: "Missing Information", message: "Please input a Title and Message to Proceed", delegate: nil, cancelButtonTitle: "Dismiss") //Invalid Username and Password Alert (No Data)
    
    var agreementAlert = UIAlertView(title: "Agreement", message: "Please agree to the terms before continuing.", delegate: nil, cancelButtonTitle: "Dismiss") //Forgot Password Alert (Used in place of a In-App reset
    
    var successAlert = UIAlertView(title: "Success", message: "Your entry has been added into the queue, please allow 24 hours for it to be approved. ", delegate: nil, cancelButtonTitle: "Dismiss") //Invalid Username and Password Alert (Wrong Data)
    
    var failAlert = UIAlertView(title: "Failure", message: "Your entry was not added into the queue, please try again later. ", delegate: nil, cancelButtonTitle: "Dismiss") //Invalid Username and Password Alert (Wrong Data)
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        titleField.delegate = self
        messageField.delegate = self
        activity.hidesWhenStopped = true;

    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //When return key is hit on the keyboard, resign back to the original state
        return true
        
    }
    
    func addNewsAPI(){
        let finalURL = "https://benjaminscheduler.com/api/?addNewsKey=dncDC402ncD2&&email=\(passUserID)&&title=\(titleFinal)&&message=\(messageFinal)";
        print(finalURL)
        let semaphore = dispatch_semaphore_create(0);
        let url: NSURL = NSURL(string: finalURL)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            var error: NSError?
            if error != nil { //Check if there is a error in the network
                if error!.localizedDescription == networkError {
                    self.statusCode = 400
                    print("Network Error: Code -1009")
                    dispatch_semaphore_signal(semaphore)
                    return
                }
            }
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                
                let code: Int = jsonData["status"] as! Int; //Return a Status Code
                self.statusCode = code
                
                dispatch_semaphore_signal(semaphore)
            }
            catch {
                // report error
            }
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    @IBAction func addNews(sender: AnyObject) {
        activity.startAnimating()
    
        
        if(titleField.text != "" && messageField.text != "") {
            if(agreeSwitch.on == true) {
                
                
                for(var k = 0; k < titleField.text!.characters.count; k++){
                    if(titleField.text![titleField.text!.startIndex.advancedBy(k)] == " "){
                        titleFinal += "%20"
                    }
                    else{
                        titleFinal.append(titleField.text![titleField.text!.startIndex.advancedBy(k)])
                    }
                }
                
                
                for(var m = 0; m < messageField.text!.characters.count; m++){
                    if(messageField.text![messageField.text!.startIndex.advancedBy(m)] == " "){
                        messageFinal += "%20"
                    }
                    else{
                        messageFinal.append(messageField.text![messageField.text!.startIndex.advancedBy(m)])
                    }
                }
                

                addNewsAPI()
                
                if(statusCode == 300){
                    successAlert.show()
                
                    let ScheduleView = self.storyboard?.instantiateViewControllerWithIdentifier("MainTabBarController") as? MainTabBarController
                    self.presentViewController(ScheduleView!, animated: true, completion: nil) //If Success, move to the Main Tab
                }
                else{
                    failAlert.show()
                    activity.stopAnimating()

                }
                
            }
            else {
                agreementAlert.show()
                activity.stopAnimating()

            }
        }
        else{
            noInfoAlert.show()
            activity.stopAnimating()

        }
    

    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool
    {
        let maxLength = 100
        let currentString: NSString = textField.text!
        let newString: NSString =
        currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    
}