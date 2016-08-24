//
//  StudentLocationTableViewController.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/14/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import Foundation

import UIKit


class StudentLocationTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var appDelegate: AppDelegate!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the app delegate
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // create and set logout button
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Reply, target: self, action: "logout")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        performUIUpdatesOnMain {
            self.tableView.reloadData()
        }
    
        
       
     }
    
    
}

// MARK: - FavoritesTableViewController (UITableViewController)

extension StudentLocationTableViewController {
    
 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // get cell type
        let cellReuseIdentifier = "StudentLocationTableViewCell"
        let studentInfo = appDelegate.studentInfo[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! StudentLocationTableViewCell!
        
        // set cell defaults
        var firstName = ""
        var lastName = ""
        
        if let fn = studentInfo.firstName {
            firstName = fn
        }
        
        if let ln = studentInfo.lastName {
            lastName = ln
        }
        
        cell.studentName.text = firstName + " " + lastName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentInfo.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let studentInfo = appDelegate.studentInfo[indexPath.row]
        
        if let studentURL = studentInfo.mediaURL {
          if let url = NSURL(string: studentURL) {
            UIApplication.sharedApplication().openURL(url)
          }
        }
        
    }

}