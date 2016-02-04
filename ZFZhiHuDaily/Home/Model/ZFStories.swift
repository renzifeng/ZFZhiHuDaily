//
//  ZFStories.swift
//
//  Created by 任子丰 on 16/1/25
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFStories: NSObject,NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFStoriesTitleKey: String = "title"
	internal let kZFStoriesTypeKey: String = "type"
	internal let kZFStoriesInternalIdentifierKey: String = "id"
	internal let kZFStoriesMultipicKey: String = "multipic"
	internal let kZFStoriesImagesKey: String = "images"
	internal let kZFStoriesGaPrefixKey: String = "ga_prefix"


    // MARK: Properties
	public var title: String?
	public var type: Int?
	public var internalIdentifier: Int?
	public var multipic: Bool = false
	public var images: [String]?
	public var gaPrefix: String?


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
		title = json[kZFStoriesTitleKey].string
		type = json[kZFStoriesTypeKey].int
		internalIdentifier = json[kZFStoriesInternalIdentifierKey].int
		multipic = json[kZFStoriesMultipicKey].boolValue

        let _images = json[kZFStoriesImagesKey].array
        
        if let _is = _images {
            images = []
            
            for i in _is {
                images?.append(i.string!)
            }
        }
		gaPrefix = json[kZFStoriesGaPrefixKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if title != nil {
			dictionary.updateValue(title!, forKey: kZFStoriesTitleKey)
		}
		if type != nil {
			dictionary.updateValue(type!, forKey: kZFStoriesTypeKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kZFStoriesInternalIdentifierKey)
		}
		dictionary.updateValue(multipic, forKey: kZFStoriesMultipicKey)
		if images?.count > 0 {
			var temp: [AnyObject] = []
			for item in images! {
				temp.append(item)
			}
			dictionary.updateValue(temp, forKey: kZFStoriesImagesKey)
		}
		if gaPrefix != nil {
			dictionary.updateValue(gaPrefix!, forKey: kZFStoriesGaPrefixKey)
		}

        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey(kZFStoriesTitleKey) as? String
        self.type = aDecoder.decodeObjectForKey(kZFStoriesTypeKey) as? Int
        self.internalIdentifier = aDecoder.decodeObjectForKey(kZFStoriesInternalIdentifierKey) as? Int
        self.multipic = aDecoder.decodeBoolForKey(kZFStoriesMultipicKey)
        self.images = aDecoder.decodeObjectForKey(kZFStoriesImagesKey) as? [String]
        self.gaPrefix = aDecoder.decodeObjectForKey(kZFStoriesGaPrefixKey) as? String
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: kZFStoriesTitleKey)
        aCoder.encodeObject(type, forKey: kZFStoriesTypeKey)
        aCoder.encodeObject(internalIdentifier, forKey: kZFStoriesInternalIdentifierKey)
        aCoder.encodeBool(multipic, forKey: kZFStoriesMultipicKey)
        aCoder.encodeObject(images, forKey: kZFStoriesImagesKey)
        aCoder.encodeObject(gaPrefix, forKey: kZFStoriesGaPrefixKey)
        
    }


}
