//
//  StyleModel.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/1.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

public class StyleModel {

    public init(){}
    public var textColor: UIColor = UIColor.black
    
    public var font: UIFont = UIFont.systemFont(ofSize: 15)
    public var fontSpace : CGFloat = 0
    public var faceOffset: CGFloat = 2
    public var tagImgSize : CGSize = CGSize(width:14,height:14)
    public var lineSpace : CGFloat = 4
    public var numberOfLines : Int = -1
    public var highlightBackgroudRadius : CGFloat = 2
    public var highlightBackgroudColor : UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    public var highlightBackgroudOffset : CGFloat = 0
    public var highligthBacjgroudAdjustHeight : CGFloat = 0
    public var urlColor : UIColor = UIColor.blue
    public var numberColor: UIColor = UIColor.blue
    public var atSomeOneColor : UIColor = UIColor.blue
    public var urlUnderLine = true
    public var urlShouldInstead : Bool = true
    public var urlInsteadtext = "网页链接"
}
