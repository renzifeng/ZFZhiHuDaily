//
//  ZFBeforeNews.swift
//
//  Created by 任子丰 on 16/1/25
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFBeforeNews: NSObject,NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFNewsDateKey: String = "date"
	internal let kZFNewsStoriesKey: String = "stories"


    // MARK: Properties
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
		date = json[kZFNewsDateKey].string
		stories = []
		if let items = json[kZFNewsStoriesKey].array {
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
		if date != nil {
			dictionary.updateValue(date!, forKey: kZFNewsDateKey)
		}
		if stories?.count > 0 {
			var temp: [AnyObject] = []
			for item in stories! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kZFNewsStoriesKey)
		}

        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObjectForKey(kZFNewsDateKey) as? String
        self.stories = aDecoder.decodeObjectForKey(kZFNewsStoriesKey) as? [ZFStories]
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: kZFNewsDateKey)
        aCoder.encodeObject(stories, forKey: kZFNewsStoriesKey)
        
    }


}
