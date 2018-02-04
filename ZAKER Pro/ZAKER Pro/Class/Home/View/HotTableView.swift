//
//  HotTableView.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import SwiftyJSON

// 20 22  107*71
class HotTableView: CYTableView,UITableViewDelegate,UITableViewDataSource {
    
    var dataList: Array<JSON>? = Array() {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        self.backgroundColor = UIColor.white
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.register(HotOneImgCell.self, forCellReuseIdentifier: "HotOneImgCell")
        self.register(HotThreeImgCell.self, forCellReuseIdentifier: "HotThreeImgCell")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(HotTableView.receiverNotification), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let params:JSON = dataList![indexPath.row]
        if self.isThreeImg(params: params) {
            let cell: HotThreeImgCell = tableView.dequeueReusableCell(withIdentifier: "HotThreeImgCell", for: indexPath) as! HotThreeImgCell
            cell.setParams(par: dataList![indexPath.row])
            return cell
        }
        
        let cell: HotOneImgCell = tableView.dequeueReusableCell(withIdentifier: "HotOneImgCell", for: indexPath) as! HotOneImgCell
        cell.setParams(par: dataList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let params:JSON = dataList![indexPath.row]
        let three = self.isThreeImg(params: params)
        if three {
            return HotThreeImgCell.cellHeight(text: params["title"].string!)
        }
        return HotOneImgCell.cellHeight()
    }
    
    func isThreeImg(params:JSON) -> Bool {
        let imgs:Array<JSON>? = params["imgnewextra"].array
        
        if imgs?.count == 2 {
            return true
        }
        return false
    }
    
    deinit {
        print("\(self) -> 释放了")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
