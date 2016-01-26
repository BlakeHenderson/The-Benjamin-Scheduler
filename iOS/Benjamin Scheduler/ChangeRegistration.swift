//
//  ChangeRegistration.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 9/28/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation

import UIKit

class ChangeRegister: UIViewController {
    
    @IBOutlet weak var update: UILabel!
    
    var success = UIAlertView(title: "Schedule Change Success.", message: "You have successfully changed your schedule.", delegate: nil, cancelButtonTitle: "Dismiss") //Default Network Error Alert
    
    var failure = UIAlertView(title: "Failure", message: "The Application could not change your information. Please contact Blake Henderson.", delegate: nil, cancelButtonTitle: "Dismiss") //Default Network Error Alert
    
    var statusCode:Int = 0;
    
    
    override func viewDidAppear(animated: Bool) {
        startParse()
    }
    
    func startParse() {
        sendData()
        if(statusCode == 300){
            print("Success")
            
            update.text = "Update Successful.";
            sleep(1)
            
            success.show()
            
            let ScheduleView = self.storyboard?.instantiateViewControllerWithIdentifier("MainTabBarController") as? MainTabBarController
            self.presentViewController(ScheduleView!, animated: true, completion: nil) //If Success, move to the Main Tab
            
        }
        else{
            print("Error in Data Parse")
            update.text = "Failure.";
            
            failure.show()
            
            let ScheduleView = self.storyboard?.instantiateViewControllerWithIdentifier("MainTabBarController") as? MainTabBarController
            self.presentViewController(ScheduleView!, animated: true, completion: nil) //If Success, move to the Main Tab
            
        }
        
        
    }

    func sendData(){
        
        var classString: String = "";
        
        print("Start #1")

        for(var i = 0; i < 7; i++){
            print("Run")
            classString += " $ " + (changeClasses[i] as! String)
        }
        
        var classStringFinal:String = "";
        
        print("Complete #1")
        
        for(var k = 0; k < classString.characters.count; k++){
            if(classString[classString.startIndex.advancedBy(k)] == " "){
                classStringFinal += "%20"
            }
            else{
                classStringFinal.append(classString[classString.startIndex.advancedBy(k)])
            }
        }
        
        print("Complete #2")
        
        var teacherString: String = "";
        
        for(var j = 0; j < 7; j++){
            teacherString += " $ " + (changeTeachers[j] as! String)
        }
        
        var teacherStringFinal: String = "";
        
        print("Complete #3")
        
        for(var m = 0; m < teacherString.characters.count; m++){
            if(teacherString[teacherString.startIndex.advancedBy(m)] == " "){
                teacherStringFinal += "%20"
            }
            else{
                teacherStringFinal.append(teacherString[teacherString.startIndex.advancedBy(m)])
            }
        }
        
        print("Complete #4")
        
        let finalURL = "https://benjaminscheduler.com/api/?updateUserLogin=jsr2e3mHaS2s&&email=\(passUserID)&&classes=\(classStringFinal)&&teachers=\(teacherStringFinal)";
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
}
