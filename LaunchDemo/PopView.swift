//
//  PopView.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import pop
enum FlyType: Int {
    case flyTypeUPToDown
    case flyTypeDownToUp
}
class PopView: UIView {

    
    var fly_w : CGFloat!
    var fly_h : CGFloat!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.addSubview(flyView)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClickAction))
        self.addGestureRecognizer(tap)
    }
    lazy var flyView : UIView = {
        let flyView = UIView()
        return flyView
    }()
    func startFly(type: FlyType){
        
        if type == .flyTypeUPToDown{
            flyView.frame = CGRect(x:SCREEN_WIDTH / 2.0 - self.fly_w / 2.0,y:-self.fly_h,width:fly_w,height:fly_h)
        }
        if type == .flyTypeDownToUp{
            flyView.frame = CGRect(x:SCREEN_WIDTH / 2.0 - self.fly_w / 2.0,y: SCREEN_HEIGHT + self.fly_h, width:self.fly_w,height: self.fly_h)
        }
        flyView.backgroundColor = UIColor.purple
        let animate = POPSpringAnimation.init(propertyNamed: kPOPViewCenter)
        animate?.toValue = NSValue.init(cgPoint: self.center)
        animate?.springSpeed = 5
        animate?.springBounciness = 10.0
        flyView.pop_add(animate, forKey: "animationShow")

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tapClickAction(){
        let animate = POPSpringAnimation.init(propertyNamed: kPOPViewCenter)
        animate?.toValue = NSValue.init(cgPoint: CGPoint(x:self.center.x,y:SCREEN_HEIGHT + self.fly_h))
        flyView.pop_add(animate, forKey: "animationRemove")
        animate?.springSpeed = 5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            self.removeFromSuperview()
        })
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
