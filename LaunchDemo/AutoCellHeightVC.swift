//
//  AutoCellHeightVC.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/11/30.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class AutoCellHeightVC: UIViewController {

    let tableView = UITableView()
    fileprivate var contents : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "计算Cell高度"
        makeCellContents()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AutoCell.classForCoder(), forCellReuseIdentifier: "auto")
        
        tableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
    }
    fileprivate func makeCellContents(){
        contents = ["皑如山上雪，皎若云间月。","闻君有两意，故来相决绝。","今日斗酒会，明旦沟水头。","躞蹀御沟上，沟水东西流。","凄凄复凄凄，嫁娶不须啼。","愿得一人心，白首不相离。","竹竿何袅袅，鱼尾何簁簁！","男儿重意气，何用钱刀为！","汉皇重色思倾国，御宇多年求不得。","杨家有女初长成，养在深闺人未识","天生丽质难自弃，一朝选在君王侧","回眸一笑百媚生，六宫粉黛无颜色","春寒赐浴华清池，温泉水滑洗凝脂","侍儿扶起娇无力，始是新承恩泽时","云鬓花颜金步摇，芙蓉帐暖度春宵。","春宵苦短日高起，从此君王不早朝"]
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
extension AutoCellHeightVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewCell.whc_CellHeightForIndexPath(indexPath, tableView: tableView)
    }
}
extension AutoCellHeightVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "auto")as!AutoCell
        cell.setContent(contents[indexPath.row], index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
}
