//
//  StudentLocationTabBarController.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/9/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class StudentLocationTabBarController : UITabBarController {
    
    var appDelegate: AppDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the app delegate
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // create and set logout button
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Reply, target: self, action: "logout")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        getStudentInfo()
        
    }
    
    func getStudentInfo() {
        
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
            self.appDelegate.studentInfo = StudentInformation.studentInfoFromResults(parsedResults)
            
            
        }
        
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        UdacityClient.sharedInstance().endUdacitySession() { (result, error) in
            performUIUpdatesOnMain {
                
                if let error = error {
                   print(error)
                   //Should I care if the logout fails
                }
                
                self.performSegueWithIdentifier("unwindToLoginViewController", sender: self)
            }
        }

    }
    
    
    @IBAction func reload(sender: AnyObject) {
        
        getStudentInfo()
        performUIUpdatesOnMain {
            self.selectedViewController?.viewWillAppear(true)
        }
        
    }
    
}

