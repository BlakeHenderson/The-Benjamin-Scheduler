//
//  Intro.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 7/23/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class IntroViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func login(sender: AnyObject) {
        let LoginView = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
        self.presentViewController(LoginView!, animated: true, completion: nil) //If Success, move to the Main Tab
        
    }
    
    @IBAction func signup(sender: AnyObject) {
    }

}
