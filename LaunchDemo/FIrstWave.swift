//
//  FIrstWave.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import Foundation
class FirstWave: UIView {

    var wavesDisplayLink : CADisplayLink!
    var firstWavesLayer : CAShapeLayer!
    var firstWavesColor : UIColor!
    private var waveA : CGFloat = 0//水纹振幅
    private var waveW : CGFloat = 0//水纹周期
    private var offsetX : CGFloat = 0//位移
    private var currentK : CGFloat = 0//当前波浪高度y
    private var waveSpeed : CGFloat = 0//水纹速度
    private var wavesWidth : CGFloat = 0//水纹宽度    
    /*
     y =Asin（ωx+φ）+C
     A表示振幅，也就是使用这个变量来调整波浪的高度
     ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
     φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
     C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
        self.setUpWave()
    }
    func setUpWave(){
        //宽度
        wavesWidth = self.frame.width
        //波浪的颜色
        firstWavesColor = UIColor.init(red: 86/255.0, green: 202/255.0, blue: 139/255.0, alpha: 1.0)
        //波浪速度
        waveSpeed = CGFloat(1.0 / M_PI)
        if firstWavesLayer == nil {
            firstWavesLayer = CAShapeLayer()
            firstWavesLayer.fillColor = firstWavesColor.cgColor
            self.layer.addSublayer(firstWavesLayer)
        }
        //波浪流动速度
        waveSpeed = 0.02
        //振幅
        waveA = 12
        //周期
        waveW = 0.5 / 30.0
        currentK = self.frame.height / 2
        //定时器=====也可以用Timer实现
        wavesDisplayLink = CADisplayLink.init(target: self, selector: #selector(getCurrentWave))
        wavesDisplayLink.add(to: RunLoop.main, forMode: .commonModes)
    }
    func getCurrentWave(){
        offsetX += waveSpeed
        setCurrentFirstWaveLayerPath()
    }
    func setCurrentFirstWaveLayerPath(){
        //创建路径
        let path = CGMutablePath()
        //
        var y = currentK
        //将点移动到 x = 0 y = currentK的位置
        path.move(to: CGPoint(x:0,y:y))
        for i in 0..<Int(wavesWidth) {
            y = waveA * cos(waveW * CGFloat(i) + offsetX) + currentK
            path.addLine(to: CGPoint(x:CGFloat(i),y:CGFloat(y)))
        }
        path.addLine(to: CGPoint(x:wavesWidth,y:0))
        path.addLine(to: CGPoint(x:0,y:0))
        path.closeSubpath()
        firstWavesLayer.path = path
        
    }
    deinit {
        wavesDisplayLink.invalidate()
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
