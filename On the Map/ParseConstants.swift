//
//  ParseConstants.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/14/16.
//  Copyright © 2016 RodCo. All rights reserved.
//


extension ParseClient {
    
    struct Constants {
        
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
        
        
        
    }
    
    struct Methods {
        
        static let StudentLocation = "/StudentLocation"
        
    }
    
    struct RequestKeys {
        
        static let AppId = "X-Parse-Application-Id"
        static let ApiKey = "X-Parse-REST-API-Key"
    }
    
    struct RequestValues {
        
        static let AppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
    }
    
    struct ParameterKeys {
        
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
    }
    
    struct JSONBodyKeys {
        

        
    }
    
    struct JSONResponseKeys {
        
        static let Results = "results"
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
        static let ACL = "ACL"
        
        
    }
    
    
    
    
}