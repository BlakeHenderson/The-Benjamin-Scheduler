
//
//  LunchViewController.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/6/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class LunchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var todayOrder: UILabel!
    @IBOutlet weak var weekOrder: UITextView!

    var todayOrderText: NSMutableArray! = NSMutableArray()
    var weekOrderText: NSMutableArray! = NSMutableArray()
    var lunchCount: NSMutableArray! = NSMutableArray()
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {

    }
    
    func lunchAPI(){
        let semaphore = dispatch_semaphore_create(0);
        let urlPath = "https://benjaminscheduler.com/api/?getLunchKey=hDc48kSw2mZ1&&benjaminID=\(passUserID)" //Login URL (API)
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            var error: NSError?
            if error != nil { //Check if there is a error in the network
                if error!.localizedDescription == networkError {
                    print("Network Error: Code -1009")
                    dispatch_semaphore_signal(semaphore)
                    return
                }
            }
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                var lunchData:NSMutableArray! = NSMutableArray()
                lunchData.addObject(jsonData["data"]!)
                for(var i = 0; i < 7; i++){
                    self.lunchCount.addObject(lunchData[0][i])
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
    
    func parseLunchData(){
        lunchAPI()
        let weeklyLunchText: NSArray = ["No Lunch Today", "Carmine's Lunch","CR Chicks/Chicken Stromboli", "Publix Subs", "Chick Fil A", "Pizza Day", "No Lunch Today"]
        let daysOfWeek: NSArray = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        let fmt = NSDateFormatter()
        let firstWeekday = 1
        let date = NSDate();
        
        //Weekday in Int
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dateFormatter.stringFromDate(date)
        print(dayOfWeekString)
        
        var currentDayInt = 0;
        
        //Get Current Day in Int
        for(var a = 0; a < 7; a++){
            if(daysOfWeek.objectAtIndex(a) as! String == dayOfWeekString){
                currentDayInt = a;
            }
        }
        
        print("Ran Array #1")

        //Current Lunch
        if lunchCount.objectAtIndex(currentDayInt) as! NSObject != 0 {
                todayOrderText[0] = "Today you ordered \(weeklyLunchText[currentDayInt])"
        }
        
        print("Ran Array #2")
        
        //Week Lunch
        for(var c: Int = 0; c < 7; c++) {
            if lunchCount.objectAtIndex(c) as! String != "0" {
                print(lunchCount.objectAtIndex(c))
                
                weekOrderText.addObject("\(daysOfWeek.objectAtIndex(c)) - \(weeklyLunchText.objectAtIndex(c)) - (\(lunchCount.objectAtIndex(c)))")
            }
        }
        
        print("Ran Array #3")
        
        todayOrder.text = todayOrderText[0] as! String
        
        var weekOrderTextString: String = ""
        
        for(var d = 0; d < weekOrderText.count; d++){
            weekOrderTextString += "\(weekOrderText[d]) \n"
        }
        
        print("Ran Array #4")
        
        weekOrder.text = weekOrderTextString
        
    }
    
    func refresh(sender:AnyObject)
    {
        todayOrderText.removeAllObjects()
        weekOrderText.removeAllObjects()
        lunchAPI()
        self.refreshControl.endRefreshing()
    }
    
}