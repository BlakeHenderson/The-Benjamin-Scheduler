//
//  HomeView.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 6/7/15.
//  Copyright (c) 2015 Blake Henderson. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBAction func sendToAppStore(sender: AnyObject) {
        let url = NSURL(string: "itms-apps://itunes.apple.com/us/app/the-benjamin-scheduler/id922491391?mt=8")
            UIApplication.sharedApplication().openURL(url!)
    }

}