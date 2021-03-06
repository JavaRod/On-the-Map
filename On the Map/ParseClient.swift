//
//  ParseClient.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/14/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import Foundation


class ParseClient : NSObject {
    
    // shared session
    var session = NSURLSession.sharedSession()
    
    
    
    
    func taskForGETMethod(method: String, var parameters: [String:AnyObject], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Set the parameters */
        //parameters[ParameterKeys.ApiKey] = Constants.ApiKey
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: ParseClient.parseURLFromParameters(parameters, withPathExtension: method))
        request.addValue(RequestValues.AppID, forHTTPHeaderField: RequestKeys.AppId)
        request.addValue(RequestValues.ApiKey, forHTTPHeaderField: RequestKeys.ApiKey)
        
        print(request.URL?.absoluteString)
        
        /* Make the request */
        let task = session.dataTaskWithRequest (request) { (data, response, error) in
            
            
            func sendError(error: String) {
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            print(NSString(data: data, encoding: NSUTF8StringEncoding))
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
            
        }
        
        task.resume()
        
        return task
        
    }
    
    
//    func startUdacitySession(username: NSString, password: NSString, completionHandlerForFavorite: (result: Bool?, error: NSError?) -> Void)  {
//        
//        /* 1. Create body of request */
//        let parameters = [:]
//        var mutableMethod: String = UdacityClient.Methods.Session
//        let jsonBody =  "{\"\(UdacityClient.JSONBodyKeys.Udacity)\": {\"\(UdacityClient.JSONBodyKeys.Username)\": \"\(username)\", \"\(UdacityClient.JSONBodyKeys.Password)\": \"\(password)\"}}"
//        
//        
//        
//        /* 2. Make the request */
//        taskForPOSTMethod(mutableMethod, parameters: parameters as! [String : AnyObject], jsonBody: jsonBody) { (results, error) in
//            
//            /* 3. Send the desired value(s) to completion handler */
//            if let error = error {
//                completionHandlerForFavorite(result: nil, error: error)
//            } else {
//                if let accountDictionary = results[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] {
//                    
//                    if let udacityUser = accountDictionary[UdacityClient.JSONResponseKeys.AccountRegistered] as? Bool {
//                        completionHandlerForFavorite(result: udacityUser, error: nil)
//                    } else {
//                        completionHandlerForFavorite(result: nil, error: NSError(domain: "postToFavoritesList parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postToFavoritesList"]))
//                    }
//                    
//                    
//                    
//                }
//            }
//        }
//    }
//    
//    func endUdacitySession(completionHandlerForFavorite: (result: Bool?, error: NSError?) -> Void)  {
//        
//        /* 1. Create body of request */
//        var mutableMethod: String = UdacityClient.Methods.Session
//        
//        
//        
//        /* 2. Make the request */
//        taskForDELETEMethod(mutableMethod) { (results, error) in
//            
//            /* 3. Send the desired value(s) to completion handler */
//            if let error = error {
//                completionHandlerForFavorite(result: nil, error: error)
//            } else {
//                if let sessionInfo = results["session"] as? [String: AnyObject] {
//                    
//                    if let sessionID = sessionInfo["id"] as? String {
//                        print(sessionID)
//                    }
//                    
//                    if let expiration = sessionInfo["expiration"] as? String {
//                        print(expiration)
//                    }
//                    completionHandlerForFavorite(result: nil, error: nil)
//                }
//            }
//        }
//    }
//    
//    
//    
//    
//    func taskForPOSTMethod(method: String, var parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        /* 1. Set the parameters */
//        //No parameters needed for this call
//        
//        /* 2/3. Build the URL, Configure the request */
//        let request = NSMutableURLRequest(URL: tmdbURLFromParameters(parameters, withPathExtension: method))
//        request.HTTPMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        /* 4. Make the request */
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//            
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForPOST(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//            }
//            
//            /* GUARD: Was there an error? */
//            guard (error == nil) else {
//                sendError("There was an error with your request: \(error)")
//                return
//            }
//            
//            /* GUARD: Check for 403 unauthorized status */
//            guard let unauthorizedStatusCode = (response as? NSHTTPURLResponse)?.statusCode where unauthorizedStatusCode != 403 else {
//                sendError("Invalid username and/or password")
//                return
//            }
//            
//            /* GUARD: Did we get a successful 2XX response? */
//            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
//                sendError("Your request returned a status code other than 2xx!")
//                return
//            }
//            
//            /* GUARD: Was there any data returned? */
//            guard let data = data else {
//                sendError("No data was returned by the request!")
//                return
//            }
//            
//            //remove first 5 characters from Udacity response.  First 5 characters are for security.
//            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
//            
//            /* 5/6. Parse the data and use the data (happens in completion handler) */
//            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
//        }
//        
//        /* 7. Start the request */
//        task.resume()
//        
//        return task
//    }
//    
//    
//    func taskForDELETEMethod(method: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
//        
//        /* 1. Set the parameters */
//        //No parameters needed for this call
//        
//        /* 2/3. Build the URL, Configure the request */
//        //let request = NSMutableURLRequest(URL: tmdbURLFromParameters(nil, withPathExtension: method))
//        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
//        request.HTTPMethod = "DELETE"
//        var xsrfCookie: NSHTTPCookie? = nil
//        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
//        for cookie in sharedCookieStorage.cookies! {
//            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
//        }
//        if let xsrfCookie = xsrfCookie {
//            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
//        }
//        
//        /* 4. Make the request */
//        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//            
//            func sendError(error: String) {
//                print(error)
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForPOST(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//            }
//            
//            /* GUARD: Was there an error? */
//            guard (error == nil) else {
//                sendError("There was an error with your request: \(error)")
//                return
//            }
//            
//            /* GUARD: Check for 403 unauthorized status */
//            guard let unauthorizedStatusCode = (response as? NSHTTPURLResponse)?.statusCode where unauthorizedStatusCode != 403 else {
//                sendError("Invalid username and/or password")
//                return
//            }
//            
//            /* GUARD: Did we get a successful 2XX response? */
//            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
//                sendError("Your request returned a status code other than 2xx!")
//                return
//            }
//            
//            /* GUARD: Was there any data returned? */
//            guard let data = data else {
//                sendError("No data was returned by the request!")
//                return
//            }
//            
//            //remove first 5 characters from Udacity response.  First 5 characters are for security.
//            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
//            
//            /* 5/6. Parse the data and use the data (happens in completion handler) */
//            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
//        }
//        
//        /* 7. Start the request */
//        task.resume()
//        
//        return task
//    }
//    
//    
//    // create a URL from parameters
//    private func tmdbURLFromParameters(parameters: [String:AnyObject]? = nil, withPathExtension: String? = nil) -> NSURL {
//        
//        let components = NSURLComponents()
//        components.scheme = UdacityClient.Constants.ApiScheme
//        components.host = UdacityClient.Constants.ApiHost
//        components.path = UdacityClient.Constants.ApiPath + (withPathExtension ?? "")
//        components.queryItems = [NSURLQueryItem]()
//        
//        if let parameterList = parameters {
//            for (key, value) in parameterList {
//                let queryItem = NSURLQueryItem(name: key, value: "\(value)")
//                components.queryItems!.append(queryItem)
//            }
//        }
//        
//        return components.URL!
//    }
//    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    
    // create a URL from parameters
    class func parseURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = ParseClient.Constants.ApiScheme
        components.host = ParseClient.Constants.ApiHost
        components.path = ParseClient.Constants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}