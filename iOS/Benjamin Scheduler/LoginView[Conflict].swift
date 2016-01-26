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
    @IBOutlet weak var rememberLogin: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forgot: UIButton!
    @IBOutlet weak var signup: UIButton!
    
    var nameOfUser = String() //Declare name of the User
    var statusCode = Int() //Status code Integer
    var usersInfoFromCore : Array<AnyObject> = [] //This is where the users info will be stored when retrieving CoreData (If there is any)
    
    var invalidLoginAlert = UIAlertView(title: "Invalid Username/Password", message: "Please input a correct Username or Password", delegate: nil, cancelButtonTitle: "Dismiss") //Invalid Username and Password Alert (Wrong Data)
    
    var noInfoLoginAlert = UIAlertView(title: "Invalid Username/Password", message: "Please input a Username and Password to Proceed", delegate: nil, cancelButtonTitle: "Dismiss") //Invalid Username and Password Alert (No Data)
    
    var forgotPasswordAlert = UIAlertView(title: "Forgot Password?", message: "Please submit a help request to the website with your Benjamin ID to reset your password.", delegate: nil, cancelButtonTitle: "Dismiss") //Forgot Password Alert (Used in place of a In-App reset
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //When return key is hit on the keyboard, resign back to the original state
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent //Sets the UIStatusBar to a "Light" configuration
    }
    
    override func viewWillAppear(animated: Bool) {
        //login() //Loads User Login - Sends them to main home screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() // Do any additional setup after loading the view, typically from a nib.
        usernameField.delegate = self
        passwordField.delegate = self
        
    }

    func login() {
        
        //activityIndicator.startAnimating()
        showNetworkIndicator()
        
        //Load Data
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "Users") //Fetch table "Users" from Core Data
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)! //Place data into a NSArray format
        
        //Find the Username and Password stored in core data and place it into the username and password fields
        if results.count > 0 {
            for user in results{
                var thisUser = user as Users
                println("Username: \(thisUser.username)")
                
                usernameField.text = thisUser.username
                passwordField.text = thisUser.password
            }
            //Login to The Benjamin Scheduler
            login(usernameField.text, password: passwordField.text)
            if statusCode == 300 {
                println("Login Success - CODE: \(statusCode) \n")
                passUserID = usernameField.text
                let MainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainTab") as MainTabBarController
                self.presentViewController(MainView, animated: true, completion: nil) //Move to the Main View of App
                activityIndicator.stopAnimating()
            }
            else if statusCode == 400 {
                activityIndicator.stopAnimating()
                hideNetworkIndicator()
                networkErrorAlert.show() //If there is a network error, show the network error notification
            }
            else {
                invalidLoginAlert.show()
                activityIndicator.stopAnimating()
                hideNetworkIndicator()
                println("Login Failed - CODE: \(statusCode) \n") //If they inputted the wrong username or password, notify them with a alert
            }
        }
        else{
            hideNetworkIndicator()
            activityIndicator.stopAnimating()
            println("No Results Found - User did not save password (Normal for First Startup)") //If there is no users stored in core data, print to log
        }
    }
    
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
        println("User Saved")
    }
    
    func loginAPI(username: String, password: String){
        let semaphore = dispatch_semaphore_create(0);
        var urlPath = "https://benjaminscheduler.com/api/?loginKey=ske745jdHDs3&benjaminID=\(username)&password=\(password)" //Login URL (API)
        var url: NSURL = NSURL(string: urlPath)!
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            var err: NSError?
            if error != nil { //Check if there is a error in the network
                if error.localizedDescription == networkError {
                    self.statusCode = 400
                    println("Network Error: Code -1009")
                    dispatch_semaphore_signal(semaphore)
                    return
                }
            }
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
            var code: Int = jsonResult["status"] as! Int; //Return a Status Code
            self.statusCode = code
            dispatch_semaphore_signal(semaphore)
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            println("User switched password save ON \n") //If the "Remember Username and Password" switch is ON
            saveLogin()
        } else {
            println("User left/switched password save OFF") //If the "Remember Username and Password" switch is OFF
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        
        activityIndicator.startAnimating()
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        if usernameField.text != "" && passwordField.text != "" {
            //Login to The Benjamin Scheduler
            login(usernameField.text, password: passwordField.text)
            if statusCode == 300 {
                println("Login Success - CODE: \(statusCode) \n")
                passUserID = usernameField.text
                let MainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainTab") as MainTabBarController
                self.presentViewController(MainView, animated: true, completion: nil) //If Success, move to the Main Tab
                activityIndicator.stopAnimating()
            }
            else if statusCode == 400 {
                networkErrorAlert.show() //If there is a network error, show the network error notification
                activityIndicator.stopAnimating()
            }
            else {
                invalidLoginAlert.show()
                activityIndicator.stopAnimating()
                println("Login Failed - CODE: \(statusCode) \n") //If they inputted the wrong username or password, notify them with a alert
            }
        }
        else {
            noInfoLoginAlert.show()
            activityIndicator.stopAnimating()
            println("Cannot Login, Invalid Information - User Did Not Input Correct Info") //If there is no users stored in core data, print to log
        }
    }
    
    @IBAction func signupSwitchView(sender: AnyObject) {
        let SignupView = self.storyboard?.instantiateViewControllerWithIdentifier("SignupView") as SignupViewController
        self.presentViewController(SignupView, animated: true, completion: nil) //If the user wants to signup for the app, display the SignupViewController
    }
    
    @IBAction func forgotPassword(sender: AnyObject) {
        forgotPasswordAlert.show() //If the user forgot his or her password
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
