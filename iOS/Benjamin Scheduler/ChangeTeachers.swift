//
//  AddTeachers.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/29/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

var changeTeacherClass = ""
var changeTeachers: NSMutableArray = ["", "", "", "", "", "", ""]

class ChangeTeachers: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var aPeriodLabel: UILabel!
    @IBOutlet weak var bPeriodLabel: UILabel!
    @IBOutlet weak var cPeriodLabel: UILabel!
    @IBOutlet weak var dPeriodLabel: UILabel!
    @IBOutlet weak var ePeriodLabel: UILabel!
    @IBOutlet weak var fPeriodLabel: UILabel!
    @IBOutlet weak var gPeriodLabel: UILabel!
    
    override func viewDidLoad() {

        aPeriodLabel.text = changeTeachers[0] as? String
        bPeriodLabel.text = changeTeachers[1] as? String
        cPeriodLabel.text = changeTeachers[2] as? String
        dPeriodLabel.text = changeTeachers[3] as? String
        ePeriodLabel.text = changeTeachers[4] as? String
        fPeriodLabel.text = changeTeachers[5] as? String
        gPeriodLabel.text = changeTeachers[6] as? String
        
        changeTeacherClass = ""
    }
    
    
    @IBAction func aPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeacherList")
        self.showViewController(vc as! ChangeTeacherList, sender: vc)
        
        changeTeacherClass = "A"
        
    }
    
    @IBAction func bPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeacherList")
        self.showViewController(vc as! ChangeTeacherList, sender: vc)
        
        changeTeacherClass = "B"
    }
    
    @IBAction func cPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeacherList")
        self.showViewController(vc as! ChangeTeacherList, sender: vc)
        
        changeTeacherClass = "C"
        
    }
    
    @IBAction func dPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeacherList")
        self.showViewController(vc as! ChangeTeacherList, sender: vc)
        
        changeTeacherClass = "D"
        
    }
    
    @IBAction func ePeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeacherList")
        self.showViewController(vc as! ChangeTeacherList, sender: vc)
        
        changeTeacherClass = "E"
        
    }
    
    @IBAction func fPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeacherList")
        self.showViewController(vc as! ChangeTeacherList, sender: vc)
        
        changeTeacherClass = "F"
        
    }
    
    @IBAction func gPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeacherList")
        self.showViewController(vc as! ChangeTeacherList, sender: vc)
        
        changeTeacherClass = "G"
        
    }
    
    
    @IBAction func `continue`(sender: AnyObject) {
        var check: Int = 0;
        print("Completed")
        for(var i = 0; i < changeTeachers.count; i++){
            if(changeTeachers[i] as! String == ""){
                check = 1
                notCompletedAlert.show()
            }
        }
        print("Running")
        if(check == 0){
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeRegister")
            self.showViewController(vc as! ChangeRegister, sender: vc)
        }
        
        check = 0;
        
    }
}