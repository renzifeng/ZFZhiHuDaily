//
//  ZFNewDetail.swift
//
//  Created by 任子丰 on 16/1/26
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFThemeDetail: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFNewDetailImageSourceKey: String = "image_source"
	internal let kZFNewDetailDescriptionValueKey: String = "description"
	internal let kZFNewDetailColorKey: String = "color"
	internal let kZFNewDetailStoriesKey: String = "stories"
	internal let kZFNewDetailImageKey: String = "image"
	internal let kZFNewDetailBackgroundKey: String = "background"
	internal let kZFNewDetailEditorsKey: String = "editors"
	internal let kZFNewDetailNameKey: String = "name"


    // MARK: Properties
    /// 图像的版权信息
	public var imageSource: String?
    /// 该主题日报的介绍
	public var descriptionValue: String?
    /// 颜色，作用未知
	public var color: Int?
    /// 该主题日报中的文章列表
	public var stories: [ZFThemeStories]?
    /// 背景图片的小图版本
	public var image: String?
    /// 该主题日报的背景图片（大图）
	public var background: String?
    /// 该主题日报的编辑
	public var editors: [ZFEditors]?
    /// 该主题日报的名称
	public var name: String?


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
		imageSource = json[kZFNewDetailImageSourceKey].string
		descriptionValue = json[kZFNewDetailDescriptionValueKey].string
		color = json[kZFNewDetailColorKey].int
		stories = []
		if let items = json[kZFNewDetailStoriesKey].array {
			for item in items {
				stories?.append(ZFThemeStories(json: item))
			}
		} else {
			stories = nil
		}
		image = json[kZFNewDetailImageKey].string
		background = json[kZFNewDetailBackgroundKey].string
		editors = []
		if let items = json[kZFNewDetailEditorsKey].array {
			for item in items {
				editors?.append(ZFEditors(json: item))
			}
		} else {
			editors = nil
		}
		name = json[kZFNewDetailNameKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if imageSource != nil {
			dictionary.updateValue(imageSource!, forKey: kZFNewDetailImageSourceKey)
		}
		if descriptionValue != nil {
			dictionary.updateValue(descriptionValue!, forKey: kZFNewDetailDescriptionValueKey)
		}
		if color != nil {
			dictionary.updateValue(color!, forKey: kZFNewDetailColorKey)
		}
		if stories?.count > 0 {
			var temp: [AnyObject] = []
			for item in stories! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kZFNewDetailStoriesKey)
		}
		if image != nil {
			dictionary.updateValue(image!, forKey: kZFNewDetailImageKey)
		}
		if background != nil {
			dictionary.updateValue(background!, forKey: kZFNewDetailBackgroundKey)
		}
		if editors?.count > 0 {
			var temp: [AnyObject] = []
			for item in editors! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kZFNewDetailEditorsKey)
		}
		if name != nil {
			dictionary.updateValue(name!, forKey: kZFNewDetailNameKey)
		}

        return dictionary
    }

}
