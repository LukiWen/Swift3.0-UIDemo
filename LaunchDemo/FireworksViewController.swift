//
//  FireworksViewController.swift
//  
//
//  Created by wzdg-whl on 16/12/15.
//
//

import UIKit

class FireworksViewController: UIViewController {

    var caELayer : CAEmitterLayer!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        let firework = FireworkView.init(frame: self.view.bounds)
        caELayer = firework.createFireWorkView()
        self.view.addSubview(firework)
        self.view.layer.addSublayer(caELayer) 
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
