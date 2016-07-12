//
//  UdacityConstants.swift
//  On the Map
//
//  Created by Rodrick Musser on 7/11/16.
//  Copyright © 2016 RodCo. All rights reserved.
//


extension UdacityClient {
    
    struct Constants {
       
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
        
    }
    
    struct Methods {
        
        static let Session = "/session"
        
    }
    
    struct JSONBodyKeys {
        
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        
    }
    
    struct JSONResponseKeys {
        
        static let Account = "account"
        static let AccountRegistered = "registered"
        static let Session = "session"
        static let SessionID = "id"
        static let SessionExpiration = "expiration"
        
    }
    
    
    
    
}
