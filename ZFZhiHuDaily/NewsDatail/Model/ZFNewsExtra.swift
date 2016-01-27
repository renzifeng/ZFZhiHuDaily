//
//  ZFNewExtra.swift
//
//  Created by 任子丰 on 16/1/27
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFNewsExtra: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFNewExtraPopularityKey: String = "popularity"
	internal let kZFNewExtraPostReasonsKey: String = "post_reasons"
	internal let kZFNewExtraCommentsKey: String = "comments"
	internal let kZFNewExtraNormalCommentsKey: String = "normal_comments"
	internal let kZFNewExtraLongCommentsKey: String = "long_comments"
	internal let kZFNewExtraShortCommentsKey: String = "short_comments"


    // MARK: Properties
	public var popularity: Int?
	public var postReasons: Int?
	public var comments: Int?
	public var normalComments: Int?
	public var longComments: Int?
	public var shortComments: Int?


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
		popularity = json[kZFNewExtraPopularityKey].int
		postReasons = json[kZFNewExtraPostReasonsKey].int
		comments = json[kZFNewExtraCommentsKey].int
		normalComments = json[kZFNewExtraNormalCommentsKey].int
		longComments = json[kZFNewExtraLongCommentsKey].int
		shortComments = json[kZFNewExtraShortCommentsKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if popularity != nil {
			dictionary.updateValue(popularity!, forKey: kZFNewExtraPopularityKey)
		}
		if postReasons != nil {
			dictionary.updateValue(postReasons!, forKey: kZFNewExtraPostReasonsKey)
		}
		if comments != nil {
			dictionary.updateValue(comments!, forKey: kZFNewExtraCommentsKey)
		}
		if normalComments != nil {
			dictionary.updateValue(normalComments!, forKey: kZFNewExtraNormalCommentsKey)
		}
		if longComments != nil {
			dictionary.updateValue(longComments!, forKey: kZFNewExtraLongCommentsKey)
		}
		if shortComments != nil {
			dictionary.updateValue(shortComments!, forKey: kZFNewExtraShortCommentsKey)
		}

        return dictionary
    }

}
