
//
//  SettingsViewController.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/6/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    var loggedOutAlert = UIAlertView(title: "Log Out", message: "You have succesfully logged out.", delegate: nil, cancelButtonTitle: "Ok")
    
    @IBAction func sendToPrivacyPolicy(sender: AnyObject) {
        
        let url = NSURL(string: "https://docs.google.com/document/u/1/d/1XTFlYyIgs0TsPLWUTwW2Hl3es5E9iD8va6mJFSoynlw/pub")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    @IBAction func onlineHelp(sender: AnyObject) {
        
        let url = NSURL(string: "https://benjaminscheduler.com")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func logout(sender: AnyObject) {
        deleteLoginInfo()
        let LoginView = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.presentViewController(LoginView, animated: true, completion: nil)
        loggedOutAlert.show()
        
    }
    
    func deleteLoginInfo() {
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Users")
        
        do{
            var results = try context.executeFetchRequest(request)
            var users: NSManagedObject!
        
            for users: AnyObject in results {
                context.deleteObject(users as! NSManagedObject)
            }
            results.removeAll(keepCapacity: false)
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        }
        catch {
            //report error
        }
    }
    
}