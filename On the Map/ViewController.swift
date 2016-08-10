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
    @IBOutlet weak var loginButton: UIButton!
    
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
        
        var loginError: NSError!
        
        setUIEnabled(false)
        
        UdacityClient.sharedInstance().startUdacitySession(email.text!, password: password.text!) { (result, error) in
            performUIUpdatesOnMain {
            
            if let error = error {
                loginError = error
                let controller = UIAlertController()
                controller.title = "Login Failed"
                controller.message = loginError.localizedDescription
                
                let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default) { action in self.dismissViewControllerAnimated(true, completion: nil)
                }
                
                controller.addAction(dismissAction)
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(controller, animated: true, completion: nil)
                }

                
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("studentLocationsSegue", sender: self)
                }
            }
                
                self.setUIEnabled(true)
            }
        }
        
        
        
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    private func setUIEnabled(enabled: Bool) {
        email.enabled = enabled
        password.enabled = enabled
        loginButton.enabled = enabled
        signUp.enabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    


}

