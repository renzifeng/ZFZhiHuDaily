//
//  ZFTopStories.swift
//
//  Created by 任子丰 on 16/1/25
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFTopStories: NSObject,NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFTopStoriesTitleKey: String = "title"
	internal let kZFTopStoriesImageKey: String = "image"
	internal let kZFTopStoriesInternalIdentifierKey: String = "id"
	internal let kZFTopStoriesGaPrefixKey: String = "ga_prefix"
	internal let kZFTopStoriesTypeKey: String = "type"


    // MARK: Properties
	public var title: String?
	public var image: String?
	public var internalIdentifier: Int?
	public var gaPrefix: String?
	public var type: Int?


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
		title = json[kZFTopStoriesTitleKey].string
		image = json[kZFTopStoriesImageKey].string
		internalIdentifier = json[kZFTopStoriesInternalIdentifierKey].int
		gaPrefix = json[kZFTopStoriesGaPrefixKey].string
		type = json[kZFTopStoriesTypeKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if title != nil {
			dictionary.updateValue(title!, forKey: kZFTopStoriesTitleKey)
		}
		if image != nil {
			dictionary.updateValue(image!, forKey: kZFTopStoriesImageKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kZFTopStoriesInternalIdentifierKey)
		}
		if gaPrefix != nil {
			dictionary.updateValue(gaPrefix!, forKey: kZFTopStoriesGaPrefixKey)
		}
		if type != nil {
			dictionary.updateValue(type!, forKey: kZFTopStoriesTypeKey)
		}

        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey(kZFTopStoriesTitleKey) as? String
        self.image = aDecoder.decodeObjectForKey(kZFTopStoriesImageKey) as? String
        self.internalIdentifier = aDecoder.decodeObjectForKey(kZFTopStoriesInternalIdentifierKey) as? Int
        self.gaPrefix = aDecoder.decodeObjectForKey(kZFTopStoriesGaPrefixKey) as? String
        self.type = aDecoder.decodeObjectForKey(kZFTopStoriesTypeKey) as? Int
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: kZFTopStoriesTitleKey)
        aCoder.encodeObject(image, forKey: kZFTopStoriesImageKey)
        aCoder.encodeObject(internalIdentifier, forKey: kZFTopStoriesInternalIdentifierKey)
        aCoder.encodeObject(gaPrefix, forKey: kZFTopStoriesGaPrefixKey)
        aCoder.encodeObject(type, forKey: kZFTopStoriesTypeKey)
        
    }


}
