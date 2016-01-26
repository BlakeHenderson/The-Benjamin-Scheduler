//
//  CompileRegister.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/29/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class CompileRegister: UIViewController {

    @IBOutlet weak var update: UILabel!
    
    var success = UIAlertView(title: "Congrats!", message: "You have successfully signed up for the scheduler. Please Sign In.", delegate: nil, cancelButtonTitle: "Dismiss") //Default Network Error Alert
    
    var failure = UIAlertView(title: "Failure", message: "The Application could not sign you up. Either we are having network problems or you have already signed up.", delegate: nil, cancelButtonTitle: "Dismiss") //Default Network Error Alert
    
    var statusCode:Int = 0;
    

    override func viewDidAppear(animated: Bool) {
        startParse()
    }
    
    func startParse() {
        sendData()
        if(statusCode == 300){
            print("Success")
            
            update.text = "Please Login.";
            sleep(1)
            
            success.show()
            
            let LoginView = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
            self.presentViewController(LoginView!, animated: true, completion: nil) //If Success, move to the Main Tab
            
        }
        else{
            print("Error in Data Parse")
            update.text = "Failure.";
            
            failure.show()
            
            let LoginView = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
            self.presentViewController(LoginView!, animated: true, completion: nil) //If Success, move to the Main Tab
 
        }
        
        
        
    }
    
    func sendData(){
        
        var classString: String = "";
        
        for(var i = 0; i < 7; i++){
            classString += " $ " + (classesAll[i] as! String)
        }
        
        var classStringFinal:String = "";
        
        for(var k = 0; k < classString.characters.count; k++){
            if(classString[classString.startIndex.advancedBy(k)] == " "){
                classStringFinal += "%20"
            }
            else{
                classStringFinal.append(classString[classString.startIndex.advancedBy(k)])
            }
        }
        
        var teacherString: String = "";
        
        for(var j = 0; j < 7; j++){
            teacherString += " $ " + (teachersAll[j] as! String)
        }
        
        var teacherStringFinal: String = "";
        
        for(var m = 0; m < teacherString.characters.count; m++){
            if(teacherString[teacherString.startIndex.advancedBy(m)] == " "){
                teacherStringFinal += "%20"
            }
            else{
                teacherStringFinal.append(teacherString[teacherString.startIndex.advancedBy(m)])
            }
        }
        
        var finalName: String = ""
        
        var preName: String = registrationInfo[0] as! String
        
        for(var n = 0; n < preName.characters.count; n++){
            if(preName[preName.startIndex.advancedBy(n)] == " "){
                finalName += "%20"
            }
            else{
                finalName.append(preName[preName.startIndex.advancedBy(n)])
            }
        }
        
        let finalURL = "https://benjaminscheduler.com/api/?storeUserLogin=jD5Sa2sFdnm9&&name=\(finalName)&&email=\(registrationInfo[1])&&password=\(registrationInfo[2])&&classes=\(classStringFinal)&&teachers=\(teacherStringFinal)";
        
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