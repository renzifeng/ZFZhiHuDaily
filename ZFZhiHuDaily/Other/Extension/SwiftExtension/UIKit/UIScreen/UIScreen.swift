//
//  Screen.swift
//  SwiftPPT
//
//  Created by 成林 on 15/6/20.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

struct Screen {
    
    
    /**  bounds  */
    static var bounds: CGRect {

        return UIScreen.mainScreen().bounds
    }
    
    /**  size  */
    static var size: CGSize {
        return self.bounds.size
    }
    
    /**  height  */
    static var height: CGFloat {
        return self.size.height
    }
    
    /**  width  */
    static var width: CGFloat{
        return self.size.width
    }

}