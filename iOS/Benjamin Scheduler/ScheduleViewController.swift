//
//  ScheduleViewController.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/6/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var className: NSMutableArray! = NSMutableArray()
    var todayTimes: NSMutableArray! = NSMutableArray()
    var tomorrowTimes: NSMutableArray! = NSMutableArray()
    
    var genericSchedule: NSMutableArray! = NSMutableArray()
    var finalSchedule: NSMutableArray! = NSMutableArray();
    var refreshControl:UIRefreshControl!
    var statusCode: Int = 0
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        
        className = []
        todayTimes = []
        tomorrowTimes = []
        
        genericSchedule = []
        finalSchedule = []
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        segmentedController.selectedSegmentIndex = 0
        
        print("Get Student Schedule...")
        scheduleAPI(passUserID)
        print("Get Today Times...")
        todayTimeAPI()
        print("Get Tomorrow Times...")
        tomorrowTimeAPI()
        print("Get Generic Schedule...")
        getAllScheduleAPI()
        print("Parse Complete Schedule...")
        parseStudentSchedule(genericSchedule[0][0]["0"] as! String)
        print("Done.\n-------------------------\n")
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            currentPage = 0
            finalSchedule.removeAllObjects()
            parseStudentSchedule(genericSchedule[0][0]["0"] as! String)
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        case 1:
            currentPage = 1
            finalSchedule.removeAllObjects()
            parseStudentSchedule(genericSchedule[0][1]["timetable"] as! String)
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        case 2:
            return;
        default:
            return;
        }
    }
    
    
    func scheduleAPI(username: String){
        let semaphore = dispatch_semaphore_create(0);
        let urlPath = "https://benjaminscheduler.com/api/?getStudentScheduleKey=sh45Fd2sda2s&&benjaminID=\(username)" //Login URL (API)
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            var error: NSError?
            if error != nil { //Check if there is a error in the network
                if error!.localizedDescription == networkError {
                    self.statusCode = 400
                    print("Network Error: Code -1009")
                    dispatch_semaphore_signal(semaphore)
                    return
                }
            }
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                var scheduleData:NSMutableArray! = NSMutableArray()
                scheduleData.addObject(jsonData["data"]!)
                for(var i = 1; i <= scheduleData[0].count-1; i++){
                    self.className.addObject(scheduleData[0][i])
                }
                dispatch_semaphore_signal(semaphore)
            }
            catch {
                // report error
            }
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    func todayTimeAPI(){
        let semaphore = dispatch_semaphore_create(0);
        let urlPath = "https://benjaminscheduler.com/api/?getScheduleTimeKey=ksDvn391Zsg7" //Time URL (API)
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            var error: NSError?
            if error != nil { //Check if there is a error in the network
                if error!.localizedDescription == networkError {
                    self.statusCode = 400
                    print("Network Error: Code -1009")
                    dispatch_semaphore_signal(semaphore)
                    return
                }
            }
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                var timeData:NSMutableArray! = NSMutableArray()
                timeData.addObject(jsonData["data"]!)
                for(var i = 0; i < timeData[0].count; i++){
                   
                    self.todayTimes.addObject(timeData[0][i])
                }
                dispatch_semaphore_signal(semaphore)
            }
            catch {
                // report error
            }
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    func tomorrowTimeAPI(){
        let semaphore = dispatch_semaphore_create(0);
        let urlPath = "https://benjaminscheduler.com/api/?getScheduleTomorrowTimeKey=fhSu57FdncCd" //Time URL (API)
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            var error: NSError?
            if error != nil { //Check if there is a error in the network
                if error!.localizedDescription == networkError {
                    self.statusCode = 400
                    print("Network Error: Code -1009")
                    dispatch_semaphore_signal(semaphore)
                    return
                }
            }
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                var timeData:NSMutableArray! = NSMutableArray()
                timeData.addObject(jsonData["data"]!)
                for(var i = 0; i < timeData[0].count; i++){
                    
                    self.tomorrowTimes.addObject(timeData[0][i])
                }
                dispatch_semaphore_signal(semaphore)
            }
            catch {
                // report error
            }
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    func getAllScheduleAPI(){
        let semaphore = dispatch_semaphore_create(0);
        let urlPath = "http://benjaminscheduler.com/api/?getAllScheduleKey=kyF4592Dcbfe" //Time URL (API)
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            var error: NSError?
            if error != nil { //Check if there is a error in the network
                if error!.localizedDescription == networkError {
                    self.statusCode = 400
                    print("Network Error: Code -1009")
                    dispatch_semaphore_signal(semaphore)
                    return
                }
            }
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    self.genericSchedule.addObject(jsonData["data"]!)
                dispatch_semaphore_signal(semaphore)
            }
            catch {
                // report error
            }
        })
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    func parseStudentSchedule(schedule:  String){
        let periods = ["A", "B", "C", "D", "E", "F", "G"]
        if schedule == "No School" {
            self.finalSchedule.addObject(schedule);
        }
        else{
            for(var j = 0; j < schedule.characters.count; j++){
                var selectedPeriod = schedule[schedule.startIndex.advancedBy(j)]
                print(selectedPeriod)
                for(var i = 0; i <= 6; i++){
                    if(periods[i].characters.contains(selectedPeriod)){
                        self.finalSchedule.addObject(className[i] as! String)
                    }
                }
            }
        }
    }
    
    func refresh(sender:AnyObject)
    {
        className.removeAllObjects()
        todayTimes.removeAllObjects()
        tomorrowTimes.removeAllObjects()
        genericSchedule.removeAllObjects()
        finalSchedule.removeAllObjects()
        scheduleAPI(passUserID)
        todayTimeAPI()
        tomorrowTimeAPI()
        getAllScheduleAPI()
        if(currentPage == 0) {
            parseStudentSchedule(genericSchedule[0][0]["0"] as! String)
        }
        else if(currentPage == 1) {
            parseStudentSchedule(genericSchedule[0][1]["timetable"] as! String)
        }
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.finalSchedule.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.textLabel?.text = finalSchedule[indexPath.row] as? String
        
        if(currentPage == 0){
            print("Today Cells")
            if(todayTimes.count != 0){
                cell.detailTextLabel?.text = todayTimes[indexPath.row] as? String
            }
            return cell
        }else{
            print("Tomorrow Cells")
            if(tomorrowTimes.count != 0){
                cell.detailTextLabel?.text = tomorrowTimes[indexPath.row] as? String
            }
            return cell
        }
    
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("showView", sender: self)
        
    }

    
    
    
}