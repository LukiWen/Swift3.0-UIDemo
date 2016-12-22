//
//  ScrollLableView.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/15.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
enum SrollDirectionType : Int {
    case FromLeftType = 0
    case FromRightType = 1
}
protocol ScrollLableViewDelegate : NSObjectProtocol {
    func drawMarqueenView(drawView : ScrollLableView,animationDidStopFinished: Bool)
}
class ScrollLableView: UIView ,CAAnimationDelegate{

    var lableDelegate : ScrollLableViewDelegate!
    var speed : Float!
    var scrollType : SrollDirectionType!
    private var width : Float!
    private var height : Float!
    private var animationViewWidth : Float!
    private var animationViewHeight : Float!
    private var stoped : Bool!
    private var contentView : UIView!
    private var animationView : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        width = Float(frame.size.width)
        height = Float(frame.size.height)
        speed = 1.0
        scrollType = SrollDirectionType.FromLeftType
        self.layer.masksToBounds = true
        self.animationView = UIView.init(frame: CGRect(x:CGFloat(self.width),y:0,width:CGFloat(self.width),height:CGFloat(self.height)))
        self.addSubview(animationView)
    }
    func addContentViewToView(view: UIView){
        if contentView != nil {
            contentView.removeFromSuperview()
        }
        view.frame  =  view.bounds
        contentView = view
        animationView.frame = view.bounds
        animationView.addSubview(contentView)
        animationViewWidth = Float(animationView.frame.size.width)
        animationViewHeight = Float(animationView.frame.size.height)
    }
    func startAnimation(){
        animationView.layer.removeAnimation(forKey: "animationViewPosition")
        stoped = false
        let pointRightCenter = CGPoint(x:CGFloat(width + animationViewWidth / 2.0),y:CGFloat(animationViewHeight / 2.0))
        let pointLeftCenter = CGPoint(x:CGFloat(-animationViewWidth / 2),y:CGFloat(animationViewHeight / 2.0))
        let fromPoint = scrollType ==  SrollDirectionType.FromLeftType ? pointRightCenter : pointLeftCenter
        let toPoint = scrollType == SrollDirectionType.FromLeftType ? pointLeftCenter : pointRightCenter
        
        animationView.center = fromPoint
        
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: fromPoint)
        
        bezierPath.addLine(to: toPoint)
        
        let moveAnimation = CAKeyframeAnimation.init(keyPath: "position")
        
        moveAnimation.path = bezierPath.cgPath
        
        moveAnimation.isRemovedOnCompletion = true
        
        moveAnimation.duration = CFTimeInterval(animationViewWidth / 30.0 * (1 / speed))
        
        moveAnimation.delegate = self
        
        animationView.layer.add(moveAnimation, forKey: "animationViewPosition")
        
    }
    func stopAnimation(){
        stoped = true
        animationView.layer.removeAnimation(forKey: "animationViewPosition")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (self.lableDelegate != nil)  {
            self.lableDelegate.drawMarqueenView(drawView: self, animationDidStopFinished: flag)
        }
        if flag && !stoped {
            self.startAnimation()
        }
    }
    func pauseAnimation(){
        pauseLayer(layer: animationView.layer)
    }
    func resumeAnimation(){
        resumeLayer(layer: animationView.layer)
    }
    func pauseLayer(layer : CALayer){
        let pauseTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pauseTime
    }
    func resumeLayer(layer: CALayer){
        let pauseTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        layer.beginTime = timeSincePause
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
