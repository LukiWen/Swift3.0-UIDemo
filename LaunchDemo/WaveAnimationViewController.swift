//
//  WaveAnimationViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class WaveAnimationViewController: UIViewController {

    var firstWave : FirstWave!
    var secondWave : SecondWave!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.alpha = 0
        firstWave = FirstWave.init(frame: CGRect(x:0,y:44,width:SCREEN_WIDTH,height:120))
        firstWave.alpha = 0.6
        secondWave = SecondWave.init(frame:CGRect(x:0,y:44,width:SCREEN_WIDTH,height:120) )
        secondWave.alpha = 0.6
        self.view.addSubview(firstWave)
        self.view.addSubview(secondWave)
        
        // 震荡效果
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(animationWave), userInfo: nil, repeats: true)
    }

    func animationWave(){
        UIView.animate(withDuration: 1, animations: {
            self.firstWave.transform = CGAffineTransform.init(translationX: 0, y: 20)
            self.secondWave.transform = CGAffineTransform.init(translationX: 0, y: 20)
        }, completion: {(finished) in
            UIView.animate(withDuration: 1, animations: {
                self.firstWave.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.secondWave.transform = CGAffineTransform.init(translationX: 0, y: 0)
            }, completion: nil)

        })
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
