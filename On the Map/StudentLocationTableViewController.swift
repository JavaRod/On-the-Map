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
    var studentLocations: [StudentInformation] = [StudentInformation]()
    
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
        
        /* TASK: Get movies from favorite list, then populate the table */
        let parameters : [String:AnyObject] = [ParseClient.ParameterKeys.Limit : 100, ParseClient.ParameterKeys.Order :  "-updatedAt"]
        let method = ParseClient.Methods.StudentLocation
        
        
        
        /* 2. Make the request */
        ParseClient.sharedInstance().taskForGETMethod(method, parameters: parameters as! [String : AnyObject]) { (results, error) in
            
            guard let parsedResults = results[ParseClient.JSONResponseKeys.Results] as? [[String:AnyObject]] else {
                print("Cannot find key '\(ParseClient.JSONResponseKeys.Results)' in (\(results)")
                return
            }
            
            /* 6. Use the data! */
            self.studentLocations = StudentInformation.studentInfoFromResults(parsedResults)
            performUIUpdatesOnMain {
                self.tableView.reloadData()
            }
    
        }
       
     }
    
    // MARK: Logout
    
    func logout() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - FavoritesTableViewController (UITableViewController)

extension StudentLocationTableViewController {
    
 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // get cell type
        let cellReuseIdentifier = "StudentLocationTableViewCell"
        let studentInfo = studentLocations[indexPath.row]
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
        return studentLocations.count
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        /* Push the movie detail view */
//        let controller = storyboard!.instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
//        controller.movie = movies[indexPath.row]
//        navigationController!.pushViewController(controller, animated: true)
//    }
}