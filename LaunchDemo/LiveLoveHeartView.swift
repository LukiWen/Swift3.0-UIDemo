//
//  LiveLoveHeartView.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class LiveLoveHeartView: UIView {

    var strokeColor : UIColor!
    var fillColor : UIColor!
    override init(frame: CGRect) {
        super.init(frame: frame)
        strokeColor = UIColor.white
        fillColor = UIColor.init(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 0.8)
        self.backgroundColor = UIColor.clear
        self.layer.anchorPoint = CGPoint(x:0.5,y:1.0)
    }
    func randomValue()->CGFloat{
        let arc = arc4random() % uint(256)
        return CGFloat(CGFloat(arc) / CGFloat(255.0))
    }
    func animateInView(view: UIView){
        
        let totalAnimationDruation = 8
        
        let heartSize = self.bounds.width
        
        let heartCenterX = self.center.x
        
        let viewHeight = view.bounds.height
        
        self.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 0.9
        }, completion: {(finished) in
            
        })
        let i = arc4random_uniform(2)
        let rotationDirection = 1 - (2 * Int(i))
        let rotationFraction = arc4random_uniform(10)
        
        UIView.animate(withDuration: TimeInterval(totalAnimationDruation), animations: {
            self.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double(rotationDirection) * M_PI / (16 + Double(rotationFraction) * 0.2)))
        }, completion: nil)
        let heartTravelPath = UIBezierPath()
        
        heartTravelPath.move(to: self.center)
        
        let endPoint = CGPoint(x:heartCenterX + CGFloat(rotationDirection) * CGFloat(2.0) * heartSize ,y:CGFloat(UInt32(viewHeight / 6.0) + arc4random_uniform(UInt32(viewHeight / 4.0))))
        
        let j = arc4random_uniform(2)
        let travelDirection = 1 - (2 * Int(j))
        
        let xDelta = (heartSize / 2.0 + 2 * heartSize) * CGFloat(travelDirection)
        
        let yDelta = max(endPoint.y, max(CGFloat(arc4random_uniform(UInt32(CGFloat(8 * heartSize)))), heartSize))
        
        let pointOne = CGPoint(x:heartCenterX + CGFloat(xDelta),y:viewHeight - yDelta)
        
        let pointTwo = CGPoint(x:heartCenterX - CGFloat(2 * xDelta),y:yDelta)
        
        heartTravelPath.addCurve(to: endPoint, controlPoint1: pointOne, controlPoint2: pointTwo)
        
        let keyFrameAnimation = CAKeyframeAnimation.init(keyPath: "position")
        
        keyFrameAnimation.path = heartTravelPath.cgPath
        
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)]
        
        keyFrameAnimation.duration = CFTimeInterval(totalAnimationDruation + Int(endPoint.y / viewHeight))
        
        self.layer.add(keyFrameAnimation, forKey: "positionOnPath")
        
        UIView.animate(withDuration:  TimeInterval(totalAnimationDruation), animations: {
            self.alpha = 0.0
        }, completion: {(rst) in
            self.removeFromSuperview()
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //画心形图
    override func draw(_ rect: CGRect) {
        strokeColor.setStroke()
        
        fillColor.setFill()
        
        let drawwingPadding = 4.0
        
        let widthDraw = rect.width - CGFloat(2 * drawwingPadding)
        
        let curveRadius = floor(widthDraw / 4.0)
        //贝塞尔曲线路径
        let heartPath = UIBezierPath()
        //心形底部
        let tipLocation = CGPoint(x:floor(rect.width / 2.0),y:rect.height - CGFloat(drawwingPadding))
        
        heartPath.move(to: tipLocation)
        //心形左边
        let topLeftCurveStart = CGPoint(x:CGFloat(drawwingPadding),y:floor(rect.height / 2.4))
        
        heartPath.addQuadCurve(to: topLeftCurveStart, controlPoint: CGPoint(x:topLeftCurveStart.x,y:topLeftCurveStart.y + curveRadius))
        
        heartPath.addArc(withCenter: CGPoint(x:topLeftCurveStart.x + curveRadius, y:topLeftCurveStart.y), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        let topRightCurveStart = CGPoint(x:topLeftCurveStart.x + 2 * curveRadius, y:topLeftCurveStart.y)
        
        heartPath.addArc(withCenter: CGPoint(x:topRightCurveStart.x + curveRadius, y:topRightCurveStart.y), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        let topRightCurveEnd = CGPoint(x:topLeftCurveStart.x + 4 * curveRadius, y:topRightCurveStart.y)
        
        heartPath.addQuadCurve(to: tipLocation, controlPoint: CGPoint(x:topRightCurveEnd.x, y:topRightCurveEnd.y + curveRadius))
        
        heartPath.fill()
        heartPath.lineWidth = 1
        heartPath.lineCapStyle = CGLineCap.round
        heartPath.lineJoinStyle = CGLineJoin.round
        heartPath.stroke()
        
        
    }
    

}
