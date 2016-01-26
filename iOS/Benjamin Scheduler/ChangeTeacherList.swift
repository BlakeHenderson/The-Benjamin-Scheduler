//
//  Teachers.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/29/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class ChangeTeacherList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var friendArray = [FriendItem]()
    var filteredFriends = [FriendItem]()
    
    var teacherArray: NSMutableArray = [
        "Mrs. Ditaranto",
        "Mr. Feyk",
        "Mr. Bazar",
        "Mrs. Wendler",
        "Dr. Peruggia",
        "Mrs. Anderson",
        "Mr. Didsbury",
        "Mrs. Gage",
        "Mrs. Steiner",
        "Ms. McGrath",
        "Mr. Ruggie",
        "Mr. Ream",
        "Mrs. August",
        "Mr. Boufford",
        "Mr. Harse",
        "Mrs. McKenney",
        "Mrs. Spino",
        "Mr. Haley",
        "Mr. Gardner",
        "Ms. Szeliga",
        "Dr. Martino",
        "Mr. Blount",
        "Mrs. Pierman",
        "Mr. McVicar",
        "Mrs. McVicar",
        "Mrs. Jefferson",
        "Mr. Lyons",
        "Mr. Harper",
        "Ms. Misselhorn",
        "Mr. Logsdon",
        "Mr. Anderson",
        "Mrs. Cohen",
        "Mrs. Salivar",
        "Ms. Jurawan",
        "Mrs. Tejera-Mede",
        "Mrs. Spassoff",
        "Mrs. Gonzalez-Lopez",
        "Mr. Sanchez",
        "Ms. Casiano",
        "Mr. Cullinane",
        "Mr. Blount",
        "Ms. Davis",
        "Mrs. Ford",
        "Mrs. Osborne",
        "Mr. Archer",
        "Dr. Nagy",
        "Mr. Kresser"
    ];
    
    override func viewDidLoad() {
        
        self.tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.teacherArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        let friend = self.teacherArray[indexPath.row]
        
        cell.textLabel?.text = friend as? String
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChangeTeachers")
        
        var classSelected = self.teacherArray[indexPath.row] as! String
        print("Current Class - " + changeTeacherClass)
        
        if(changeTeacherClass == "A"){
            print("A - " + classSelected)
            changeTeachers[0] = self.teacherArray[indexPath.row] as! String
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        else if(changeTeacherClass == "B"){
            print("B - " + classSelected)
            changeTeachers[1] = self.teacherArray[indexPath.row] as! String
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        else if(changeTeacherClass == "C"){
            print("C - " + classSelected)
            changeTeachers[2] = self.teacherArray[indexPath.row] as! String
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        else if(changeTeacherClass == "D"){
            print("D - " + classSelected)
            changeTeachers[3] = self.teacherArray[indexPath.row] as! String
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        else if(changeTeacherClass == "E"){
            print("E - " + classSelected)
            changeTeachers[4] = self.teacherArray[indexPath.row] as! String
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        else if(changeTeacherClass == "F"){
            print("F - " + classSelected)
            changeTeachers[5] = self.teacherArray[indexPath.row] as! String
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        else if(changeTeacherClass == "G"){
            print("G - " + classSelected)
            changeTeachers[6] = self.teacherArray[indexPath.row] as! String
            self.showViewController(vc as! ChangeTeachers, sender: vc)
        }
        
    }
    
}