//
//  FeedModel.swift
//  RSS
//
//  Created by Eric Alvarado on 6/6/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class FeedModel: NSObject, NSXMLParserDelegate {
    
    let feedUrl = "http://www.theverge.com/rss/frontpage"
    var articles = [Article]()
    
    // Parser variables
    var currentElement = ""
    var foundCharacters = ""
    var attributes:[NSObject:AnyObject]?
    var currentlyConstructingArticle = Article()
    
    // Methods
    
    func getArticles() {
        
         // Initialize a new parser; Note: Intially used the wrong NSURL method!
        let feedNSUrl = NSURL(string: feedUrl)
        
        let feedParser = NSXMLParser(contentsOfURL: feedNSUrl!)
        
        if let actualFeedParser = feedParser {
            // Download feed and parse articles
            
            // Assigning "self" as the Delegate for XMLParser
            actualFeedParser.delegate = self
            
            // Start the parsing process
            actualFeedParser.parse()
        }
    } // getArticles

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        if elementName == "entry" || elementName == "title" || elementName == "content" || elementName == "link" {
            currentElement = elementName
            attributes = attributeDict
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if let chars = string {
            
            if self.currentElement == "entry" ||
                self.currentElement == "title" ||
                self.currentElement == "content" ||
                self.currentElement == "link" {
                    
                    self.foundCharacters += chars
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            // Add found characters which should be title to temp Article object
            currentlyConstructingArticle.articleTitle = foundCharacters
            
            // Clear the foundCharacters buffer
            foundCharacters = ""
        } else if elementName == "content" {
            // Add found characters which should be title to temp Article object
            currentlyConstructingArticle.articleDescription = foundCharacters
            
            // TODO: Extract out article image and save it to the articleImageURL property
            
            // Clear the foundCharacters buffer
            foundCharacters = ""
        } else if elementName == "link" {
            // Parsing of the link element is complete, grab the href from the attributes dictionary
            // Note: Need to unwrap the dictionary object
            currentlyConstructingArticle.articleLink = attributes!["href"] as! String
            
            // Clear the foundCharacters buffer
            foundCharacters = ""
        } else if elementName == "entry" {
            // Parsing of the entry element is complete, append the article object onto the array and start a new article object
            articles.append(currentlyConstructingArticle)
            
            // Empty currentlyConstructingArticle
            currentlyConstructingArticle = Article()
            
            // Clear the foundCharacters buffer
            foundCharacters = ""
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        // TODO: Notify VC that the array of articles is ready
    }
    
}
