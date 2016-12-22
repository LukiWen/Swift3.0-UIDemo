//
//  LiveLoveHeartViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class LiveLoveHeartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(showLoveHeartView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
    }

    func showLoveHeartView(){
        let heartView = LiveLoveHeartView.init(frame: CGRect(x:0,y:0,width:40,height:40))
        self.view.addSubview(heartView)
        let fountain = CGPoint(x:self.view.frame.size.width - 80,y:self.view.frame.size.height - 30 / 2.0 - 10)
        heartView.center = fountain
        heartView.animateInView(view: self.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
