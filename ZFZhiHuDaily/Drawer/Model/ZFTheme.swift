//
//  ZFOthers.swift
//
//  Created by 任子丰 on 16/2/2
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFTheme: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFOthersNameKey: String = "name"
	internal let kZFOthersDescriptionValueKey: String = "description"
	internal let kZFOthersInternalIdentifierKey: String = "id"
	internal let kZFOthersThumbnailKey: String = "thumbnail"
	internal let kZFOthersColorKey: String = "color"


    // MARK: Properties
	public var name: String?
	public var descriptionValue: String?
	public var internalIdentifier: Int?
	public var thumbnail: String?
	public var color: Int?


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
		name = json[kZFOthersNameKey].string
		descriptionValue = json[kZFOthersDescriptionValueKey].string
		internalIdentifier = json[kZFOthersInternalIdentifierKey].int
		thumbnail = json[kZFOthersThumbnailKey].string
		color = json[kZFOthersColorKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if name != nil {
			dictionary.updateValue(name!, forKey: kZFOthersNameKey)
		}
		if descriptionValue != nil {
			dictionary.updateValue(descriptionValue!, forKey: kZFOthersDescriptionValueKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kZFOthersInternalIdentifierKey)
		}
		if thumbnail != nil {
			dictionary.updateValue(thumbnail!, forKey: kZFOthersThumbnailKey)
		}
		if color != nil {
			dictionary.updateValue(color!, forKey: kZFOthersColorKey)
		}

        return dictionary
    }

}
