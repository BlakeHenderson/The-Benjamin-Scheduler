//
//  AddClasses.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/29/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

var changeClassSelected = ""
var changeClasses: NSMutableArray = ["", "", "", "", "", "", ""]

class ChangeClasses: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var aPeriodLabel: UILabel!
    @IBOutlet weak var bPeriodLabel: UILabel!
    @IBOutlet weak var cPeriodLabel: UILabel!
    @IBOutlet weak var dPeriodLabel: UILabel!
    @IBOutlet weak var ePeriodLabel: UILabel!
    @IBOutlet weak var fPeriodLabel: UILabel!
    @IBOutlet weak var gPeriodLabel: UILabel!
    
    override func viewDidLoad() {
        aPeriodLabel.text = changeClasses[0] as? String
        bPeriodLabel.text = changeClasses[1] as? String
        cPeriodLabel.text = changeClasses[2] as? String
        dPeriodLabel.text = changeClasses[3] as? String
        ePeriodLabel.text = changeClasses[4] as? String
        fPeriodLabel.text = changeClasses[5] as? String
        gPeriodLabel.text = changeClasses[6] as? String
        
        changeClassSelected = ""
    }
    
    
    @IBAction func aPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeClassList")
        self.showViewController(vc as! ChangeClassList, sender: vc)
        
        changeClassSelected = "A"
    }
    
    @IBAction func bPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeClassList")
        self.showViewController(vc as! ChangeClassList, sender: vc)
        
        changeClassSelected = "B"
        
    }
    
    @IBAction func cPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeClassList")
        self.showViewController(vc as! ChangeClassList, sender: vc)
        
        changeClassSelected = "C"
        
    }
    
    @IBAction func dPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeClassList")
        self.showViewController(vc as! ChangeClassList, sender: vc)
        
        changeClassSelected = "D"
        
    }
    
    @IBAction func ePeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeClassList")
        self.showViewController(vc as! ChangeClassList, sender: vc)
        
        changeClassSelected = "E"
        
    }
    
    @IBAction func fPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeClassList")
        self.showViewController(vc as! ChangeClassList, sender: vc)
        
        changeClassSelected = "F"
        
    }
    
    @IBAction func gPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeClassList")
        self.showViewController(vc as! ChangeClassList, sender: vc)
        
        changeClassSelected = "G"
        
    }
    
    @IBAction func `continue`(sender: AnyObject) {
        var check: Int = 0;
        
        for(var i = 0; i < changeClasses.count; i++){
            if(changeClasses[i] as! String == ""){
                check = 1
                notCompletedAlert.show()
            }
        }
        
        if(check == 0){
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeachers")
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        
        check = 0;
        
    }
}