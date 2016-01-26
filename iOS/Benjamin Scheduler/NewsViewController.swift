//
//  NewsViewController.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 8/6/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var titleText: NSMutableArray! = NSMutableArray()
    var subtitleText: NSMutableArray! = NSMutableArray()
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        newsAPI()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func newsAPI(){
        let semaphore = dispatch_semaphore_create(0);
        let urlPath = "https://benjaminscheduler.com/api/?getCurrentNewsKey=jFd34kdFnbU6" //Login URL (API)
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
                    var scheduleData:NSMutableArray! = NSMutableArray()
                    scheduleData.addObject(jsonData["data"]!)
                
                for(var i = 0; i < scheduleData[0][0].count; i++){
                    self.titleText.addObject(scheduleData[0][0][i])
                }
                
                for(var j = 0; j < scheduleData[0][1].count; j++){
                    self.subtitleText.addObject(scheduleData[0][1][j])
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
    
    func refresh(sender:AnyObject)
    {
        titleText = []
        subtitleText = []
        newsAPI()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.titleText.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.detailTextLabel?.numberOfLines = 2
        
        cell.textLabel?.text = titleText[indexPath.row] as? String
        cell.detailTextLabel?.text = subtitleText[indexPath.row] as? String
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("showView", sender: self)
        
    }
    

    
    
}