//
//  ZFStories.swift
//
//  Created by 任子丰 on 16/1/26
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFThemeStories: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFStoriesTitleKey: String = "title"
	internal let kZFStoriesInternalIdentifierKey: String = "id"
	internal let kZFStoriesImagesKey: String = "images"
	internal let kZFStoriesTypeKey: String = "type"


    // MARK: Properties
    /// 消息的标题
	public var title: String?
    /// 数据库中的唯一表示符
	public var internalIdentifier: Int?
    /// 图像地址（其类型为数组。请留意在代码中处理无该属性与数组长度为 0 的情况）
	public var images: [String]?
    /// 类型，作用未知
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
		title = json[kZFStoriesTitleKey].string
		internalIdentifier = json[kZFStoriesInternalIdentifierKey].int
        let _images = json[kZFStoriesImagesKey].array
        if let _is = _images {
            images = []
            for i in _is {
                images?.append(i.string!)
            }
        }
		type = json[kZFStoriesTypeKey].int

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
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kZFStoriesInternalIdentifierKey)
		}
		if images?.count > 0 {
			var temp: [AnyObject] = []
			for item in images! {
				temp.append(item)
			}
			dictionary.updateValue(temp, forKey: kZFStoriesImagesKey)
		}
		if type != nil {
			dictionary.updateValue(type!, forKey: kZFStoriesTypeKey)
		}

        return dictionary
    }

}
