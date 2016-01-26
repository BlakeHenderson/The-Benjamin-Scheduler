//
//  Classes.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/29/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

var addClass = "";

class Classes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var classArray: NSMutableArray = ["001 - AP English Language",
        "002 - AP English Literature",
        "009 - Writing Across the Genres",
        "010 - Introduction to World Lit.",
        "014 - Expository Writing - Fall",
        "015 - Expository Writing - Spring",
        "020 - American Literature",
        "025 - Honors American Lit.",
        "030 - Western Literature",
        "045 - SS: Reading & the Reel World",
        "046 - SS: Literature of the City",
        "047 - SS: From Page to Stage",
        "048 - SS: Science Fiction",
        "050 - SS: Contemporary Lit.",
        "053 - Film Analysis",
        "059 - Speech",
        "108 - AP Calculus AB",
        "110 - AP Statistics",
        "113 - Algebra I",
        "114 - Honors Geometry",
        "122 - Algebra II",
        "124 - Geometry",
        "126 - Honors Algebra II",
        "137 - Honors Pre-Calculus",
        "140 - Calculus",
        "141 - Statistical Thinking",
        "142 - Finite Mathematics",
        "143 - AP Calculus BC",
        "157 - Pre-Calculus",
        "203 - AP Biology",
        "204 - AP Chemistry",
        "205 - AP Physics",
        "210 - Biotechnology",
        "212 - Biotechnology II",
        "213 - Biology",
        "214 - Honors Biology",
        "224 - Chemistry",
        "227 - Honors Chemistry",
        "235 - Physics",
        "237 - Honors Physics",
        "241 - Human Biological Systems",
        "257 - Marine Science",
        "258 - Oceanography",
        "262 - Advanced Research",
        "265 - Introduction to Engineering",
        "267 - Structural Design",
        "268 - Electronics",
        "269 - Design and Fabrication",
        "300 - AP Human Geography",
        "301 - AP Economics",
        "303 - AP US History",
        "305 - AP European History",
        "308 - AP Government",
        "313 - World History",
        "323 - US History",
        "325 - Intro to Government",
        "326 - Intro to Economics",
        "333 - Intro to Law",
        "358 - Contemporary Issues",
        "365 - History of Florida",
        "367 - Olympics",
        "369 - Modern Middle East",
        "401 - Chinese I",
        "402 - Chinese II",
        "403 - Honors Chinese III",
        "404 - Honors Chinese IV",
        "405 - AP Chinese",
        "406 - AP Spanish",
        "409 - AP French",
        "410 - Spanish Conversation",
        "450 - French Conversation",
        "461-462 - Spanish II",
        "463 - Spanish III",
        "464 - Spanish IV",
        "465 - Honors Spanish V",
        "466 - Spanish I",
        "476 - Honors Spanish III",
        "477 - Honors Spanish IV",
        "478 - Honors French IV",
        "479 - Honors French III",
        "492 - French II",
        "493 - French III",
        "495 - Honors French V",
        "496 - French I",
        "503 - AP Computer Science",
        "547 - Game Design",
        "552 - Computer Programming",
        "557 - Adv. Research in CS",
        "559 - Intro to Computer Science",
        "600 - Intro to Photography",
        "604 - Intermediate Photography",
        "605 - Portfolio",
        "606 - AP Studio Art",
        "607 - Advanced Photography",
        "616 - AP Photo",
        "628 - TV Studio & Field Production",
        "629 - TV Broadcasting I",
        "630 - Film Production",
        "631 - TV Broadcasting II - Fall",
        "632 - TV Broadcasting II - Spring",
        "633 - Studio Art Painting",
        "636 - Intermediate Ceramics",
        "637 - AP Art History",
        "647 - Chamber",
        "649 - Concert Band",
        "651 - Chorus",
        "658 - Piano I & II - Fall",
        "661 - Ceramics",
        "665 - Foundations in Art",
        "666 - Sculpture",
        "668 - Advanced Ceramics",
        "675 - Acting Techniques",
        "682 - Intro to Theater",
        "685 - Print Productions",
        "699 - Dance Techniques",
        "762 - Physical Education",
        "800 - Study Hall",
        "000 - No Class/Free Period"]
    
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
        return self.classArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        let friend = self.classArray[indexPath.row]
        
        cell.textLabel?.text = friend as? String
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("AddClasses")
        
        var classSelected = self.classArray[indexPath.row] as! String
        print("Current Class - " + currentClassSelected)
        
        if(currentClassSelected == "A"){
            print("A - " + classSelected)
            classesAll[0] = self.classArray[indexPath.row] as! String
            self.showViewController(vc as! AddClasses, sender: vc)
            print(classesAll)
        }
        else if(currentClassSelected == "B"){
            print("B - " + classSelected)
            classesAll[1] = self.classArray[indexPath.row] as! String
            self.showViewController(vc as! AddClasses, sender: vc)
            print(classesAll)

        }
        else if(currentClassSelected == "C"){
            print("C - " + classSelected)
            classesAll[2] = self.classArray[indexPath.row] as! String
            self.showViewController(vc as! AddClasses, sender: vc)
            print(classesAll)

        }
        else if(currentClassSelected == "D"){
            print("D - " + classSelected)
            classesAll[3] = self.classArray[indexPath.row] as! String
            self.showViewController(vc as! AddClasses, sender: vc)
            print(classesAll)

        }
        else if(currentClassSelected == "E"){
            print("E - " + classSelected)
            classesAll[4] = self.classArray[indexPath.row] as! String
            self.showViewController(vc as! AddClasses, sender: vc)
            print(classesAll)

        }
        else if(currentClassSelected == "F"){
            print("F - " + classSelected)
            classesAll[5] = self.classArray[indexPath.row] as! String
            self.showViewController(vc as! AddClasses, sender: vc)
            print(classesAll)

        }
        else if(currentClassSelected == "G"){
            print("G - " + classSelected)
            classesAll[6] = self.classArray[indexPath.row] as! String
            self.showViewController(vc as! AddClasses, sender: vc)
            print(classesAll)

        }

        
    }


}