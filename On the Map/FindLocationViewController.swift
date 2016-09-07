//
//  FindLocationViewController.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/24/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import Foundation
import UIKit


class FindLocationViewController: UIViewController {
    
    // MARK: Properties
    
    var appDelegate: AppDelegate!
    


    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.backgroundColor = UIColor.grayColor()

        //titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .Center
        
        // get the app delegate
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
 
        let labelText = createAttributedString("Where are you \n", font: UIFont(name: "Roboto-Thin", size: 15)!, color: UIColor.blueColor())
        labelText.appendAttributedString(createAttributedString("studying \n", font: UIFont(name: "Roboto-Medium", size: 15)!, color: UIColor.blueColor()))
        labelText.appendAttributedString(createAttributedString("today?", font: UIFont(name: "Roboto-Thin", size: 15)!, color: UIColor.blueColor()))
        
        
        titleLabel.attributedText = labelText
        titleLabel.textAlignment = NSTextAlignment.Center
        
  
    
        

    }
    
    
    func createAttributedString(string: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        
        let attrs = [NSFontAttributeName: font, NSForegroundColorAttributeName: color]
        return NSMutableAttributedString(string: string, attributes: attrs)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // self.navigationController!.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 160.0)
    }
    
    
}