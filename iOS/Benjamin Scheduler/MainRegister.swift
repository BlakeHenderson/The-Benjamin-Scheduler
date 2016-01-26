//
//  MainRegister.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 6/7/15.
//  Copyright (c) 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

var registrationInfo: NSMutableArray = []

class MainRegister: UIViewController, UITextFieldDelegate {
    
    var invalidPasswordAlert = UIAlertView(title: "Passwords do not match", message: "Please re-enter your password and try again.", delegate: nil, cancelButtonTitle: "Dismiss") //Default Network Error Alert
    
     var noInfoRegisterAlert = UIAlertView(title: "Invalid Information", message: "Please input all of the information to proceed", delegate: nil, cancelButtonTitle: "Ok")
    
    var invalidEmailAlert = UIAlertView(title: "Invalid Information", message: "Please input a Benjamin Email to Proceed", delegate: nil, cancelButtonTitle: "Ok")
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        name.delegate = self
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //When return key is hit on the keyboard, resign back to the original state
        return true
        
    }
    
    @IBAction func `continue`(sender: AnyObject) {
        if(name.text != "" && email.text != "" && password.text != "" && confirmPassword.text != ""){
            if(email.text?.containsString("@thebenjaminschool.org") == false){
               invalidEmailAlert.show()
            }
            else{
                if(password.text == confirmPassword.text){
                    registrationInfo.addObject(name.text!)
                    registrationInfo.addObject(email.text!)
                    registrationInfo.addObject(password.text!)
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("AddClasses")
                    self.showViewController(vc as! AddClasses, sender: vc)
                }
                else{
                    invalidPasswordAlert.show()
                    password.text = ""
                    confirmPassword.text = ""
                    password.resignFirstResponder()
                    confirmPassword.resignFirstResponder()
                }
            }
        }
        else {
            noInfoRegisterAlert.show()
        }

        
        
    }


}