//
//  StringExtension.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/15.
//  Copyright © 2016年 WHL. All rights reserved.
//

import Foundation
import UIKit
extension NSString{
    func widthWithStringAttribute(attribute : NSDictionary)->Float{
        var width = 0.0
        if self.length > 0 {
            let rect = self.boundingRect(with: CGSize(width:CGFloat(MAXFLOAT),height:0), options: [NSStringDrawingOptions.truncatesLastVisibleLine,NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading],  attributes: (attribute as! [String : Any]), context: nil)
            width = Double(rect.size.width)
        }
        return Float(width)
    }
}
