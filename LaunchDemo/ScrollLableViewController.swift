//
//  ScrollLableViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/16.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class ScrollLableViewController: UIViewController {

    var lable : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        let drawScroll1 = ScrollLableView.init(frame: CGRect(x:0,y:104,width:self.view.frame.size.width,height:20))
        let drawScroll2 = ScrollLableView.init(frame: CGRect(x:0,y:124,width:self.view.frame.size.width,height:20))
        let drawScroll3 = ScrollLableView.init(frame: CGRect(x:0,y:144,width:self.view.frame.size.width,height:20))
        let drawScroll4 = ScrollLableView.init(frame: CGRect(x:0,y:164,width:self.view.frame.size.width,height:20))
        drawScroll1.lableDelegate = self
        drawScroll2.lableDelegate = self
        drawScroll3.lableDelegate = self
        drawScroll4.lableDelegate = self
        
        drawScroll4.scrollType = SrollDirectionType.FromLeftType
        drawScroll3.scrollType = SrollDirectionType.FromLeftType
        drawScroll2.scrollType = SrollDirectionType.FromLeftType
        drawScroll1.scrollType = SrollDirectionType.FromLeftType
        self.view.addSubview(drawScroll1)
        self.view.addSubview(drawScroll2)
        self.view.addSubview(drawScroll3)
        self.view.addSubview(drawScroll4)
        
        drawScroll1.addContentViewToView(view: self.createLableWithText(text: "我就是来搞笑的，哈哈", textColor: randomColor()))
        drawScroll2.addContentViewToView(view: self.createLableWithText(text: "严肃点不要笑", textColor: randomColor()))
        drawScroll3.addContentViewToView(view: self.createLableWithText(text: "深井冰", textColor: randomColor()))
        drawScroll4.addContentViewToView(view: self.createLableWithText(text: "SBBBBBBB", textColor: randomColor()))
        drawScroll1.startAnimation()
        drawScroll2.startAnimation()
        drawScroll3.startAnimation()
        drawScroll4.startAnimation()
   
    }

    func createLableWithText(text : NSString, textColor: UIColor)->UILabel{
        let string = text
        let width = string.widthWithStringAttribute(attribute: [NSFontAttributeName : UIFont.systemFont(ofSize: 16)])
        let lable = UILabel.init(frame: CGRect(x:0,y:0,width:CGFloat(width),height:20))
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.text = text as String
        lable.textColor = textColor
        return lable
    }
    func randomColor()->UIColor{
        return UIColor.init(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1.0)
    }
    func randomValue()->CGFloat{
        let arc = arc4random() % uint(256)
        return CGFloat(CGFloat(arc) / CGFloat(255.0))
    }

    func randomString()->NSString{
        let arrStr = ["英俊","潇洒","风流","倜傥","玉树","临风","的屌丝"]
        return arrStr[Int(arc4random()) % arrStr.count] as NSString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ScrollLableViewController : ScrollLableViewDelegate{
    func drawMarqueenView(drawView: ScrollLableView, animationDidStopFinished: Bool) {
        
        drawView.stopAnimation()
        
        let delay = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline:delay) {
            drawView.addContentViewToView(view: self.createLableWithText(text: self.randomString(), textColor: self.randomColor()))
            drawView.startAnimation()
        }

    }
}
