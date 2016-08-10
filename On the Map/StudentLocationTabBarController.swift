//
//  StudentLocationTabBarController.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/9/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class StudentLocationTabBarController : UITabBarController {
    
    
    
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
    
    
    
}

