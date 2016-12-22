//
//  FromViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import pop
class FromViewController: UIViewController,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let presentButton = UIButton.init(type: .custom)
        presentButton.frame = CGRect(x:0,y:300,width:SCREEN_WIDTH,height:20)
        presentButton.setTitle("PresentVC", for: .normal)
        presentButton.setTitleColor(UIColor.red, for: .normal)
        presentButton.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
        self.view.addSubview(presentButton)
        
        let pushButton = UIButton.init(type: .custom)
        pushButton.frame = CGRect(x:0,y:380,width:SCREEN_WIDTH,height:20)
        pushButton.setTitle("pushVC", for: .normal)
        pushButton.setTitleColor(UIColor.red, for: .normal)
        pushButton.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        self.view.addSubview(pushButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func presentVC(){
        let modalVC = ToViewController()
        modalVC.transitioningDelegate = self
        modalVC.type = "present"
        modalVC.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(modalVC, animated: true, completion: nil)
    }
    func pushVC(){
        let modalVC = ToViewController()
        self.navigationController?.delegate = self
        modalVC.type = "push"
        self.navigationController?.pushViewController(modalVC, animated: true)
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PresentAnimation()
        }else{
            return nil
        }
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
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
