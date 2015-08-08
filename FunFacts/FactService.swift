//
//  FactService.swift
//  FunFacts
//
//  Created by Adrian Fraisse on 04/08/2015.
//  Copyright (c) 2015 Adrian Fraisse. All rights reserved.
//

import Foundation

class FactService {
    
    let wsURL = NSURL(string: "http://localhost:8080/facts/random")
    var data : NSData?
    
    func getRandomFact() -> (author: String, content: String) {
        var res : NSData?
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: wsURL!), queue: NSOperationQueue.mainQueue(), completionHandler:
            {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    // The request returned data
                    // Retrieving json content
                    println("Got data from the WS")
                    self.data = data
                } else if let error = error {
                    println("Failed to reach web-service \(error.description)")
                }
        })

    }
}