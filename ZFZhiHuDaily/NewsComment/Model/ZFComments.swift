//
//  ZFComments.swift
//
//  Created by 任子丰 on 16/1/30
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFComments: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFCommentsAuthorKey: String = "author"
	internal let kZFCommentsContentKey: String = "content"
	internal let kZFCommentsInternalIdentifierKey: String = "id"
	internal let kZFCommentsAvatarKey: String = "avatar"
	internal let kZFCommentsLikesKey: String = "likes"
	internal let kZFCommentsTimeKey: String = "time"


    // MARK: Properties
	public var author: String?
	public var content: String?
	public var internalIdentifier: Int?
	public var avatar: String?
	public var likes: Int?
	public var time: Int?


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
		author = json[kZFCommentsAuthorKey].string
		content = json[kZFCommentsContentKey].string
		internalIdentifier = json[kZFCommentsInternalIdentifierKey].int
		avatar = json[kZFCommentsAvatarKey].string
		likes = json[kZFCommentsLikesKey].int
		time = json[kZFCommentsTimeKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if author != nil {
			dictionary.updateValue(author!, forKey: kZFCommentsAuthorKey)
		}
		if content != nil {
			dictionary.updateValue(content!, forKey: kZFCommentsContentKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kZFCommentsInternalIdentifierKey)
		}
		if avatar != nil {
			dictionary.updateValue(avatar!, forKey: kZFCommentsAvatarKey)
		}
		if likes != nil {
			dictionary.updateValue(likes!, forKey: kZFCommentsLikesKey)
		}
		if time != nil {
			dictionary.updateValue(time!, forKey: kZFCommentsTimeKey)
		}

        return dictionary
    }

}
