//
//  ViewController.swift
//  On the Map
//
//  Created by Rodrick Musser on 7/10/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
   
    
    @IBOutlet weak var signUp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureSignUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureSignUp() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "userSignUp:")
        tapGesture.numberOfTapsRequired = 1
        signUp.userInteractionEnabled = true
        signUp.addGestureRecognizer(tapGesture)
        
        
    }
    
    func userSignUp(recognizer: UITapGestureRecognizer)  {
        let url = NSURL(string: "https://www.udacity.com/account/auth#!/signup")!
        UIApplication.sharedApplication().openURL(url)
    }

    @IBAction func loginPressed(sender: AnyObject) {
        
        UdacityClient.sharedInstance().startUdacitySession(email.text!, password: password.text!) { (result, error) in
            if let error = error {
                print(error)
            } else {
                print(result)
            }
        }
        
    }

}

