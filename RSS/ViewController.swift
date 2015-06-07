//
//  ViewController.swift
//  RSS
//
//  Created by Eric Alvarado on 5/29/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let feedModel = FeedModel()
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize request and download articles in the background
        feedModel.getArticles()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Place holder
    }

}

