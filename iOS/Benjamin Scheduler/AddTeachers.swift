//
//  AddTeachers.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/29/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

var addTeacherClass = ""
var teachersAll: NSMutableArray = ["", "", "", "", "", "", ""]

class AddTeachers: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var aPeriodLabel: UILabel!
    @IBOutlet weak var bPeriodLabel: UILabel!
    @IBOutlet weak var cPeriodLabel: UILabel!
    @IBOutlet weak var dPeriodLabel: UILabel!
    @IBOutlet weak var ePeriodLabel: UILabel!
    @IBOutlet weak var fPeriodLabel: UILabel!
    @IBOutlet weak var gPeriodLabel: UILabel!
    
    override func viewDidLoad() {
        aPeriodLabel.text = teachersAll[0] as? String
        bPeriodLabel.text = teachersAll[1] as? String
        cPeriodLabel.text = teachersAll[2] as? String
        dPeriodLabel.text = teachersAll[3] as? String
        ePeriodLabel.text = teachersAll[4] as? String
        fPeriodLabel.text = teachersAll[5] as? String
        gPeriodLabel.text = teachersAll[6] as? String
        
        currentClassSelected = ""
    }

    
    @IBAction func aPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Teachers")
        self.showViewController(vc as! Teachers, sender: vc)
        
        addTeacherClass = "A"
        
    }
    
    @IBAction func bPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Teachers")
        self.showViewController(vc as! Teachers, sender: vc)
        
        addTeacherClass = "B"
    }
    
    @IBAction func cPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Teachers")
        self.showViewController(vc as! Teachers, sender: vc)
        
        addTeacherClass = "C"
        
    }
    
    @IBAction func dPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Teachers")
        self.showViewController(vc as! Teachers, sender: vc)
        
        addTeacherClass = "D"
        
    }
    
    @IBAction func ePeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Teachers")
        self.showViewController(vc as! Teachers, sender: vc)
        
        addTeacherClass = "E"
        
    }
    
    @IBAction func fPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Teachers")
        self.showViewController(vc as! Teachers, sender: vc)
        
        addTeacherClass = "F"
        
    }
    
    @IBAction func gPeriodAdd(sender: AnyObject) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Teachers")
        self.showViewController(vc as! Teachers, sender: vc)
        
        addTeacherClass = "G"
        
    }
    
    
    @IBAction func `continue`(sender: AnyObject) {
        var check: Int = 0;
        
        for(var i = 0; i < teachersAll.count; i++){
            if(teachersAll[i] as! String == ""){
                check = 1
                notCompletedAlert.show()
            }
        }
        
        if(check == 0){
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("CompileRegister")
            self.showViewController(vc as! CompileRegister, sender: vc)
        }
        
        check = 0;
        
    }
}