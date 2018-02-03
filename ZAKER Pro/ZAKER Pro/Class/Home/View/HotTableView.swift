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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HotOneImgCell = tableView.dequeueReusableCell(withIdentifier: "HotOneImgCell", for: indexPath) as! HotOneImgCell
        cell.setParams(par: dataList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HotOneImgCell.cellHeight
    }
    
    deinit {
        print("\(self) -> 释放了")
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
