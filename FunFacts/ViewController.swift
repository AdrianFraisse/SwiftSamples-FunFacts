//
//  ViewController.swift
//  FunFacts
//
//  Created by Adrian Fraisse on 02/08/2015.
//  Copyright (c) 2015 Adrian Fraisse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let wsURL = NSURL(string: "http://localhost:8080/facts/random")
    
    // weak : type de connexion et de gestion mémoire
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!
    @IBOutlet weak var funFactAuthorLabel: UILabel!
    
    let factBook = FactBook()
    let colorWheel = ColorWheel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        funFactLabel.text = factBook.factsArray[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showFunFact() {
        var color = colorWheel.randomColor()
        self.view.backgroundColor = color
        funFactButton.tintColor = color
       
        // request a random fact from the web service
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: wsURL!), queue: NSOperationQueue.mainQueue(), completionHandler:
            {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    // The request returned data
                    // Retrieving json content
                    println("Got data from the WS")
                    if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String: AnyObject],
                        author = json["author"] as? String,
                        content = json["content"] as? String {
                            
                        println("Retrieved data from the web service : \(author) - \(content)");
                        self.funFactLabel.text = content
                        self.funFactAuthorLabel.text = "- \(author)"
                    }
                } else if let error = error {
                    // A fact couldn't be retrieved - We use a local one
                    println("Failed to reach web-service \(error.description)")
                    self.funFactLabel.text = self.factBook.randomFact()
                    self.funFactAuthorLabel.text = "- Some guy"
                }
        })
        
    }


}

