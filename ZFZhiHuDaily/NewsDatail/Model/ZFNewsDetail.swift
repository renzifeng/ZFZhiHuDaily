//
//  ZFNewDetail.swift
//
//  Created by 任子丰 on 16/1/27
//  Copyright (c) 任子丰. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZFNewsDetail: NSObject,NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kZFNewDetailTitleKey: String = "title"
	internal let kZFNewDetailCssKey: String = "css"
	internal let kZFNewDetailShareUrlKey: String = "share_url"
	internal let kZFNewDetailInternalIdentifierKey: String = "id"
	internal let kZFNewDetailBodyKey: String = "body"
	internal let kZFNewDetailJsKey: String = "js"
	internal let kZFNewDetailImageKey: String = "image"
	internal let kZFNewDetailGaPrefixKey: String = "ga_prefix"
	internal let kZFNewDetailImageSourceKey: String = "image_source"
	internal let kZFNewDetailTypeKey: String = "type"

    // MARK: Properties
    /// 标题
	public var title: String?
    /// 网页的css的url地址
	public var css: [String]?
    /// 分享地址
	public var shareUrl: String?
    /// 新闻的ID
	public var internalIdentifier: Int?
    /// 主要的内容
	public var body: String?
     /// 网页js的url地址
	public var js: [String]?
    /// 图片的URL
	public var image: String?
    /// 无用
	public var gaPrefix: String?
    /// 图片版权
	public var imageSource: String?
    /// 新闻类型  内部新闻是0  外联是1
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
		title = json[kZFNewDetailTitleKey].string
		css = []
		if let items = json[kZFNewDetailCssKey].array {
			for item in items {
				if let tempValue = item.string {
				css?.append(tempValue)
				}
			}
		} else {
			css = nil
		}
		shareUrl = json[kZFNewDetailShareUrlKey].string
		internalIdentifier = json[kZFNewDetailInternalIdentifierKey].int
		body = json[kZFNewDetailBodyKey].string
		if let items = json[kZFNewDetailJsKey].array {
            for item in items {
                if let tempValue = item.string {
                    js?.append(tempValue)
                }
            }
		} else {
			js = nil
		}
		image = json[kZFNewDetailImageKey].string
		gaPrefix = json[kZFNewDetailGaPrefixKey].string
		imageSource = json[kZFNewDetailImageSourceKey].string
		type = json[kZFNewDetailTypeKey].int
    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if title != nil {
			dictionary.updateValue(title!, forKey: kZFNewDetailTitleKey)
		}
		if css?.count > 0 {
			dictionary.updateValue(css!, forKey: kZFNewDetailCssKey)
		}
		if shareUrl != nil {
			dictionary.updateValue(shareUrl!, forKey: kZFNewDetailShareUrlKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kZFNewDetailInternalIdentifierKey)
		}
		if body != nil {
			dictionary.updateValue(body!, forKey: kZFNewDetailBodyKey)
		}
		if image != nil {
			dictionary.updateValue(image!, forKey: kZFNewDetailImageKey)
		}
		if gaPrefix != nil {
			dictionary.updateValue(gaPrefix!, forKey: kZFNewDetailGaPrefixKey)
		}
		if imageSource != nil {
			dictionary.updateValue(imageSource!, forKey: kZFNewDetailImageSourceKey)
		}
		if type != nil {
			dictionary.updateValue(type!, forKey: kZFNewDetailTypeKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey(kZFNewDetailTitleKey) as? String
        self.css = aDecoder.decodeObjectForKey(kZFNewDetailCssKey) as? [String]
        self.shareUrl = aDecoder.decodeObjectForKey(kZFNewDetailShareUrlKey) as? String
        self.internalIdentifier = aDecoder.decodeObjectForKey(kZFNewDetailInternalIdentifierKey) as? Int
        self.body = aDecoder.decodeObjectForKey(kZFNewDetailBodyKey) as? String
        self.image = aDecoder.decodeObjectForKey(kZFNewDetailImageKey) as? String
        self.gaPrefix = aDecoder.decodeObjectForKey(kZFNewDetailGaPrefixKey) as? String
        self.imageSource = aDecoder.decodeObjectForKey(kZFNewDetailImageSourceKey) as? String
        self.type = aDecoder.decodeObjectForKey(kZFNewDetailTypeKey) as? Int
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: kZFNewDetailTitleKey)
        aCoder.encodeObject(css, forKey: kZFNewDetailCssKey)
        aCoder.encodeObject(shareUrl, forKey: kZFNewDetailShareUrlKey)
        aCoder.encodeObject(internalIdentifier, forKey: kZFNewDetailInternalIdentifierKey)
        aCoder.encodeObject(body, forKey: kZFNewDetailBodyKey)
        aCoder.encodeObject(js, forKey: kZFNewDetailJsKey)
        aCoder.encodeObject(image, forKey: kZFNewDetailImageKey)
        aCoder.encodeObject(gaPrefix, forKey: kZFNewDetailGaPrefixKey)
        aCoder.encodeObject(imageSource, forKey: kZFNewDetailImageSourceKey)
        aCoder.encodeObject(type, forKey: kZFNewDetailTypeKey)
        
    }

}
