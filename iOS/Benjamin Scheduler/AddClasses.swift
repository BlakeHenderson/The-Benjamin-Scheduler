//
//  AddClasses.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/29/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

var currentClassSelected = ""
var classesAll: NSMutableArray = ["", "", "", "", "", "", ""]

var notCompletedAlert = UIAlertView(title: "Incomplete Fields", message: "Please make sure you fill out all of the fields before continuing.", delegate: nil, cancelButtonTitle: "Dismiss") //Default Network

class AddClasses: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var aPeriodLabel: UILabel!
    @IBOutlet weak var bPeriodLabel: UILabel!
    @IBOutlet weak var cPeriodLabel: UILabel!
    @IBOutlet weak var dPeriodLabel: UILabel!
    @IBOutlet weak var ePeriodLabel: UILabel!
    @IBOutlet weak var fPeriodLabel: UILabel!
    @IBOutlet weak var gPeriodLabel: UILabel!
    
    override func viewDidLoad() {
        aPeriodLabel.text = classesAll[0] as? String
        bPeriodLabel.text = classesAll[1] as? String
        cPeriodLabel.text = classesAll[2] as? String
        dPeriodLabel.text = classesAll[3] as? String
        ePeriodLabel.text = classesAll[4] as? String
        fPeriodLabel.text = classesAll[5] as? String
        gPeriodLabel.text = classesAll[6] as? String

        currentClassSelected = ""
    }


    @IBAction func aPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
        self.showViewController(vc as! Classes, sender: vc)
        
        currentClassSelected = "A"
    }

    @IBAction func bPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
        self.showViewController(vc as! Classes, sender: vc)
        
        currentClassSelected = "B"
        
    }
    
    @IBAction func cPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
        self.showViewController(vc as! Classes, sender: vc)
        
        currentClassSelected = "C"
        
    }
    
    @IBAction func dPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
        self.showViewController(vc as! Classes, sender: vc)
        
        currentClassSelected = "D"
        
    }
    
    @IBAction func ePeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
        self.showViewController(vc as! Classes, sender: vc)
        
        currentClassSelected = "E"
        
    }
    
    @IBAction func fPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
        self.showViewController(vc as! Classes, sender: vc)
        
        currentClassSelected = "F"
        
    }
    
    @IBAction func gPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
        self.showViewController(vc as! Classes, sender: vc)
        
        currentClassSelected = "G"
        
    }
    
    @IBAction func `continue`(sender: AnyObject) {
        var check: Int = 0;
        
        for(var i = 0; i < classesAll.count; i++){
            if(classesAll[i] as! String == ""){
                check = 1
                notCompletedAlert.show()
            }
        }
        
        if(check == 0){
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("AddTeachers")
            self.showViewController(vc as! AddTeachers, sender: vc)
        }
        
        check = 0;
        
    }
}