//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var optional : String? = "hello"

if let s = optional {
    println(s)
}


var random = Int(arc4random_uniform(10))


var redColor = UIColor(red: 223/255.0, green: 86/255.0, blue: 100/255.5, alpha: 1.0)


let wsURL = NSURL(string: "http://localhost:8080/facts/random")
NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: wsURL!), queue: NSOperationQueue.mainQueue(), completionHandler:
    {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
        if let content = data {
            // The request returned data
            let result: AnyObject? = NSJSONSerialization.JSONObjectWithData(content, options: NSJSONReadingOptions.AllowFragments, error: nil)
            println(result)
        } else if let error = error {
            println("Failed to reach web-service \(error.description)")
        }
})
