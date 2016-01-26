//
//  ZFEditors.swift
//
//  Created by 任子丰 on 16/1/26
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFEditors: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFEditorsNameKey: String = "name"
	internal let kZFEditorsInternalIdentifierKey: String = "id"
	internal let kZFEditorsAvatarKey: String = "avatar"
	internal let kZFEditorsUrlKey: String = "url"
	internal let kZFEditorsBioKey: String = "bio"


    // MARK: Properties
    /// 主编的姓名
	public var name: String?
    /// 数据库中的唯一表示符
	public var internalIdentifier: Int?
    /// 主编的头像
	public var avatar: String?
    /// 主编的知乎用户主页
	public var url: String?
    /// 主编的个人简介
	public var bio: String?


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
		name = json[kZFEditorsNameKey].string
		internalIdentifier = json[kZFEditorsInternalIdentifierKey].int
		avatar = json[kZFEditorsAvatarKey].string
		url = json[kZFEditorsUrlKey].string
		bio = json[kZFEditorsBioKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if name != nil {
			dictionary.updateValue(name!, forKey: kZFEditorsNameKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kZFEditorsInternalIdentifierKey)
		}
		if avatar != nil {
			dictionary.updateValue(avatar!, forKey: kZFEditorsAvatarKey)
		}
		if url != nil {
			dictionary.updateValue(url!, forKey: kZFEditorsUrlKey)
		}
		if bio != nil {
			dictionary.updateValue(bio!, forKey: kZFEditorsBioKey)
		}

        return dictionary
    }

}
