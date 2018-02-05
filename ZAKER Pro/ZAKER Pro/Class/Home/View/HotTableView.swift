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
    
    var dataList: Array<HotCellModel>? = Array() {
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(HotTableView.receiverNotification), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let params:HotCellModel = dataList![indexPath.row]
        
//        判断是否是视频
        
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
        return self.calculCellHeight(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.calculCellHeight(indexPath: indexPath)
    }
    
    func calculCellHeight(indexPath: IndexPath) -> CGFloat {

        let params:HotCellModel = dataList![indexPath.row]

        let three = self.isThreeImg(params: params)
        
        let cellHeight = params.cellHeight
        if cellHeight == nil {
            var newHeight: CGFloat
            if three {
                newHeight = HotThreeImgCell.cellHeight(text: params.title!)
            } else {
                newHeight = HotOneImgCell.cellHeight()
            }
            params.cellHeight = newHeight
            return newHeight
        }
        
        return cellHeight!
    }
    
    func isThreeImg(params: HotCellModel) -> Bool {
        let imgs:Array<String>? = params.imgnewextra
        
        if imgs?.count == 2 {
            return true
        }
        return false
    }
    
    deinit {
        print("\(self) -> 释放了")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func receiverNotification() {
        self.beginUpdates()
        self.reloadData()
        self.endUpdates()
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
