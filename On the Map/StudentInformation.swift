//
//  StudentInformation.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/14/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

struct StudentInformation {
    
    // MARK: Properties
    
    let objectId    :   String?
    let uniqueKey   :   String?
    let firstName   :   String?
    let lastName    :   String?
    let mapString   :   String?
    let mediaURL    :   String?
    let latitude    :   Float?
    let longitude   :   Float?
    let createdAt   :   String?
    let updatedAt   :   String?
    let ACL         :   String?
    
    
    // MARK: Initializers
    
    // construct a TMDBMovie from a dictionary
    init(dictionary: [String:AnyObject]) {
        
        objectId = dictionary[ParseClient.JSONResponseKeys.ObjectID] as? String
       uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Float
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Float
        createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as? String
        updatedAt = dictionary[ParseClient.JSONResponseKeys.UpdatedAt] as? String
        ACL = dictionary[ParseClient.JSONResponseKeys.ACL] as? String
    
        
    }
    
    static func studentInfoFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var studentInformations = [StudentInformation]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            studentInformations.append(StudentInformation(dictionary: result))
        }
        
        return studentInformations
    }
}

// MARK: - TMDBMovie: Equatable

extension StudentInformation: Equatable {}

func ==(lhs: StudentInformation, rhs: StudentInformation) -> Bool {
    return lhs.objectId == rhs.objectId
}