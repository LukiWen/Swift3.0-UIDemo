//
//  AutoCell.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/1.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class AutoCell: UITableViewCell {

    fileprivate let myLable = UILabel()
    fileprivate let title = UILabel()
    fileprivate let content = UILabel()
    fileprivate let tableView = UITableView()
    fileprivate var otherLable : UILabel!
    fileprivate var indexCell : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        self.contentView.addSubview(myLable)
        self.contentView.addSubview(title)
        self.contentView.addSubview(content)
        self.contentView.addSubview(tableView)
        title.text = "nickName"
        myLable.textAlignment = .center
        myLable.backgroundColor = UIColor.white
        tableView.whc_AutoWidth(left: 10, top: 0, right: 10, height: 30)
        title.whc_Left(10, toView: myLable).whc_Top(5, toView: self).whc_Right(10).whc_Height(20)
        myLable.whc_Left(10).whc_Top(10, toView: self).whc_Size(30, height: 30)
        myLable.layer.cornerRadius = 15
        myLable.layer.masksToBounds = true
        myLable.layer.borderWidth = 2
        myLable.layer.borderColor = UIColor.lightGray.cgColor
        content.whc_Top(0, toView: title).whc_Left(10, toView: myLable).whc_Right(10).whc_Height(20)
        tableView.whc_Top(5, toView: content).whc_LeftEqual(myLable).whc_Right(10).whc_Height(44)
        self.whc_CellBottomOffset = 10
        self.whc_CellTableView = tableView
    }
    func setContent(_ content : String,index : Int)->Void{
        self.content.text = content
        myLable.text = String(index + 1)
        indexCell = index
        tableView.reloadData()
        tableView.whc_Height(tableView.contentSize.height)
        if index < 5 {
            if otherLable == nil {
                otherLable = UILabel()
                otherLable.backgroundColor = UIColor.magenta
            }
            otherLable.text = content
            if !self.contentView.subviews.contains(otherLable) {
                self.contentView.addSubview(otherLable)
                otherLable.whc_Top(10, toView: tableView).whc_Left(10, toView: myLable).whc_Right(10)
                .whc_HeightAuto()
            }
            self.whc_CellBottomView = otherLable
        }else{
            if otherLable != nil && self.contentView.subviews.contains(otherLable) {
                otherLable.removeFromSuperview()
            }
            self.whc_CellBottomView = tableView
        }
    }
    func getUrls(str: String)->[String]{
        var urls = [String]()
        do{
            let dataDetector = try! NSDataDetector.init(types: NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            let res = dataDetector.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: NSMakeRange(0, str.characters.count))
            for checkingRes in res {
                 urls.append((str as NSString).substring(with: checkingRes.range))
            }
        }
        return urls
        
    }
//    func subStr(string : String)->NSMutableAttributedString{
//        let regularString = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
//        let regex = try? NSRegularExpression.init(pattern: regularString, options: .caseInsensitive)
//        let arrMacthes = regex?.matches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: UInt(0)), range: NSMakeRange(0, string.lengthOfBytes(using: String.Encoding.utf8)))
//        let mArr = NSMutableArray()
//        let rangeArr = NSArray()
//        for match in arrMacthes! {
//            let subStringForMachth = string.substring(with: string.range(of: string)!)
//            mArr.add(subStringForMachth)
//        }
//        var subStr = string
//        for str in mArr {
//            subStr = subStr.replacingOccurrences(of: str as! String, with: "链接")
//        }
////        rangeArr = self.
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension AutoCell : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
extension AutoCell : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "auto")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "auto")
        }
        cell?.textLabel?.text = "哈哈哈...呵呵"
        let urls = self.getUrls(str: (cell?.textLabel?.text)!)
        print(urls)
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if indexCell % 2 != 0 {
            return 10
        }
        return 5
    }
}
