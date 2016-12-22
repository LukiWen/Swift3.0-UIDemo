//
//  ToViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class ToViewController: UIViewController {

    var type : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 0.3373, green: 0.8809, blue: 0.9846, alpha: 1.0)
        let dismissButton = UIButton.init(type: .custom)
        dismissButton.frame = CGRect(x:SCREEN_WIDTH / 2.0 - 50,y:SCREEN_HEIGHT / 2,width:100,height:60)
        dismissButton.tintColor = UIColor.white
        dismissButton.backgroundColor = UIColor.black
        dismissButton.titleLabel?.font = UIFont.init(name: "Avenir", size: 20)
        dismissButton.setTitle("dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        self.view.addSubview(dismissButton)
    }

    func dismiss(_ sender: UIButton){
        if self.type == "push" {
            _ = self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
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
