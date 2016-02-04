//
//  ZFLatestNews.swift
//
//  Created by 任子丰 on 16/1/25
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFLatestNews: NSObject,NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFLatestNewsTopStoriesKey: String = "top_stories"
	internal let kZFLatestNewsDateKey: String = "date"
	internal let kZFLatestNewsStoriesKey: String = "stories"


    // MARK: Properties
	public var topStories: [ZFTopStories]?
	public var date: String?
	public var stories: [ZFStories]?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		topStories = []
		if let items = json[kZFLatestNewsTopStoriesKey].array {
			for item in items {
				topStories?.append(ZFTopStories(json: item))
			}
		} else {
			topStories = nil
		}
		date = json[kZFLatestNewsDateKey].string
		stories = []
		if let items = json[kZFLatestNewsStoriesKey].array {
			for item in items {
				stories?.append(ZFStories(json: item))
			}
		} else {
			stories = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if topStories?.count > 0 {
			var temp: [AnyObject] = []
			for item in topStories! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kZFLatestNewsTopStoriesKey)
		}
		if date != nil {
			dictionary.updateValue(date!, forKey: kZFLatestNewsDateKey)
		}
		if stories?.count > 0 {
			var temp: [AnyObject] = []
			for item in stories! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kZFLatestNewsStoriesKey)
		}

        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.topStories = aDecoder.decodeObjectForKey(kZFLatestNewsTopStoriesKey) as? [ZFTopStories]
        self.date = aDecoder.decodeObjectForKey(kZFLatestNewsDateKey) as? String
        self.stories = aDecoder.decodeObjectForKey(kZFLatestNewsStoriesKey) as? [ZFStories]
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(topStories, forKey: kZFLatestNewsTopStoriesKey)
        aCoder.encodeObject(date, forKey: kZFLatestNewsDateKey)
        aCoder.encodeObject(stories, forKey: kZFLatestNewsStoriesKey)
        
    }

}
