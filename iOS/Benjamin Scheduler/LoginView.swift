//
//  LoginView.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 6/7/15.
//  Copyright (c) 2015 Blake Henderson. All rights reserved.
//
//  Code References: Santhosh Marripelli on 27/06/14.
//

import UIKit
import Foundation

//Import CoreData to store users login information (If they choose to save their password)
import CoreData
import LocalAuthentication

//Declare Global Variables
var passUserID: String = String() //The Users ID - Benjamin School ID
var networkError = "The operation couldn’t be completed. (NSURLErrorDomain error -1009.)" //Network Error - Server Connection Problem
var networkErrorAlert = UIAlertView(title: "Network Error", message: "The Application could not connect to the server, please try again later.", delegate: nil, cancelButtonTitle: "Dismiss") //Default Network Error Alert
var updates = UIAlertView(title: "Updates in Progress", message: "We are currently preforming updates on the server, please try again momentarily", delegate: nil, cancelButtonTitle: "Ok") //Updates Alert

//Declare Login Class: UIViewController, UITextField Delegate
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var nameOfUser = String() //Declare name of the User
    var statusCode = Int() //Status code Integer
    var usersInfoFromCore : Array<AnyObject> = [] //This is where the users info will be stored when retrieving CoreData (If there is any)
    
    var invalidLoginAlert = UIAlertView(title: "Invalid Username/Password", message: "Please input a correct Username or Password", delegate: nil, cancelButtonTitle: "Dismiss") //Invalid Username and Password Alert (Wrong Data)
    
    var noInfoLoginAlert = UIAlertView(title: "Invalid Username/Password", message: "Please input a Username and Password to Proceed", delegate: nil, cancelButtonTitle: "Dismiss") //Invalid Username and Password Alert (No Data)
    
    var forgotPasswordAlert = UIAlertView(title: "Forgot Password?", message: "Please submit a help request to the website with your Benjamin ID to reset your password.", delegate: nil, cancelButtonTitle: "Dismiss") //Forgot Password Alert (Used in place of a In-App reset

    override func viewDidLoad() {
        super.viewDidLoad() // Do any additional setup after loading the view, typically from a nib.
        activity.startAnimating()
        usernameField.delegate = self
        passwordField.delegate = self
        activity.hidesWhenStopped = true;
    }
    
    override func viewDidAppear(animated: Bool) {
        loadUser()
        activity.stopAnimating()
    }
    
    func saveUser() {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
        
        var newUser = Users(entity: ent!, insertIntoManagedObjectContext: context)
        newUser.username = usernameField.text!
        newUser.password = passwordField.text!
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        print(newUser)
        print("Object Saved")
        
    }
    
    func loadUser(){
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false;
        
        do{
            let results:NSArray = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for user in results {
                    
                    let thisUser = user as! Users
                    
                    print("The Users Username is \(thisUser.username)")
                    
                    usernameField.text = thisUser.username
                    passwordField.text = thisUser.password
                    
                    loginAPI(thisUser.username, password: thisUser.password)
                    
                    if statusCode == 300 {
                        print("Login Success - CODE: \(statusCode) \n")
                        passUserID = usernameField.text!
                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("MainTabBarController")
                        self.showViewController(vc as! MainTabBarController, sender: vc)
                        
                    }
                    else if statusCode == 400 {
                        networkErrorAlert.show() //If there is a network error, show the network error notification
                    }
                    else {
                        invalidLoginAlert.show()
                        print("Login Failed - CODE: \(statusCode) \n") //If they inputted the wrong username or password, notify them with a alert
                    }
                }
            }
            else {
                    print("No Results Found - User did not save password (Normal for First Startup)") //If there is no users stored in core data, print to log
                }
        }
        catch {
            print(error)
        }
        
        activity.stopAnimating()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //When return key is hit on the keyboard, resign back to the original state
        return true
        
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        print("Beginning Login Sequence...");
        
        if usernameField.text != "" && passwordField.text != "" {
            //Login to The Benjamin Scheduler
            print("Sending Login Info...")
            loginAPI(usernameField.text!, password: passwordField.text!)
            print("Recieved Login Info...")
            if statusCode == 300 {
                print("Login Success - CODE: \(statusCode) \n")
                passUserID = usernameField.text!
                saveUser()
                self.tabBarController?.selectedIndex = 1;
                let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("MainTabBarController")
                self.showViewController(vc as! MainTabBarController, sender: vc)
                activity.stopAnimating()
                activity.hidden = true
            }
            else if statusCode == 400 {
                networkErrorAlert.show() //If there is a network error, show the network error notification
                activity.stopAnimating()
                activity.hidden = true
            }
            else {
                invalidLoginAlert.show()
                print("Login Failed - CODE: \(statusCode) \n") //If they inputted the wrong username or password, notify them with a alert
                activity.stopAnimating()
                activity.hidden = true
            }
        }
        else {
            noInfoLoginAlert.show()
            print("Cannot Login, Invalid Information - User Did Not Input Correct Info") //If there is no users stored in core data, print to log
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent //Sets the UIStatusBar to a "Light" configuration
    }
    
    override func viewWillAppear(animated: Bool) {
        //login() //Loads User Login - Sends them to main home screen
        print("Welcome");
    }
    
  /*
    func saveLogin() {
        //Save Data to CoreData
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context) //Creates a Entity for the table Users
        
        
        //Instance of custom class, reference to entity allows for dot notation
        var newUser = Users(entity: ent!, insertIntoManagedObjectContext: context)
        
        //Fill in the Core Data
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        //Save Data
        context.save(nil)
        
        println(newUser)
        print("User Saved")
    }
    */
    
    func loginAPI(username: String, password: String){
        activity.startAnimating()
        let semaphore = dispatch_semaphore_create(0);
        let urlPath = "https://benjaminscheduler.com/api/?loginKey=ske745jdHDs3&&benjaminID=\(username)&&password=\(password)" //Login URL (API)
        let url: NSURL = NSURL(string: urlPath)!
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
    
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}