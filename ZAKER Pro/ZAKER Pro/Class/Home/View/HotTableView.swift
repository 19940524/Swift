//
//  HotTableView.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import SwiftyJSON
import ESPullToRefresh

protocol HotTableViewDelegate: class {
    func promptEvent(text: String)
}

// 20 22  107*71
class HotTableView: CYTableView,UITableViewDelegate,UITableViewDataSource {
    
    var dataList: Array<HotCellModel>? = Array() {
        didSet {
            self.reloadData()
        }
    }
    
    var fn: Int = 0
    weak var hotDelegate: HotTableViewDelegate?
    public var rootVC: CYHomeVC? = nil
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        self.backgroundColor = UIColor.white
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.register(HotOneImgCell.self, forCellReuseIdentifier: "HotOneImgCell")
        self.register(HotThreeImgCell.self, forCellReuseIdentifier: "HotThreeImgCell")
        self.register(HotVideoCell.self, forCellReuseIdentifier: "HotVideoCell")
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = HotRefreshHeaderAnimator(frame: CGRect.zero)
        self.es.addPullToRefresh(animator: header) { [weak self] in
            self?.refresh()
        }
        
        let footer:HotRefreshFooterAnimator = HotRefreshFooterAnimator(frame: CGRect.zero)
    
        self.es.addInfiniteScrolling(animator: footer) { [weak self] in
            self?.loadingMore()
        }
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(HotTableView.receiverNotification), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        self.refresh()
        
    }
    
    private func refresh() {
        
        HotHandler.GETHotHData(fn: fn, success: { (json) in
            
            var newList: Array<HotCellModel> = Array()
            let jsonData = JSON.init(json)
            for params in jsonData["tid"].arrayValue {
                let model:HotCellModel = HotCellModel()
                model.setParams(params: params)
                newList.append(model)
            }
            
            if self.dataList!.count > 0 {
                self.dataList?.remove(at: 0)
            }
            
            self.dataList?.insert(contentsOf: newList, at: 0)
            self.es.stopPullToRefresh()
            self.fn += 1
            
            let model:HotCellModel = (self.dataList?.first)!
            if model.prompt != nil {
                self.hotDelegate?.promptEvent(text: model.prompt!)
            }
            
        }) { (json) in
            self.es.stopPullToRefresh()
        }
    }
    
    private func loadingMore() {
        let offset: Int = (self.dataList?.count)!
        HotHandler.GETHotFData(offset: offset, fn: fn, success: { (json) in
           
            var newList: Array<HotCellModel> = Array()
            let jsonData = JSON.init(json)
            for params in jsonData["tid"].arrayValue {
                let model:HotCellModel = HotCellModel()
                model.setParams(params: params)
                newList.append(model)
            }
            self.dataList?.append(contentsOf: newList)
            
            
            self.es.stopLoadingMore()
        }) { (json) in
            self.es.stopLoadingMore()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let params:HotCellModel = dataList![indexPath.row]
        
//        判断是否是视频
        if params.boardid == "video_bbs" {
            let cell: HotVideoCell = tableView.dequeueReusableCell(withIdentifier: "HotVideoCell", for: indexPath) as! HotVideoCell
            cell.setParams(par: dataList![indexPath.row])
            return cell
        } else {
            if self.isThreeImg(params: params) {
                let cell: HotThreeImgCell = tableView.dequeueReusableCell(withIdentifier: "HotThreeImgCell", for: indexPath) as! HotThreeImgCell
                cell.setParams(par: dataList![indexPath.row])
                return cell
            } else {
                let cell: HotOneImgCell = tableView.dequeueReusableCell(withIdentifier: "HotOneImgCell", for: indexPath) as! HotOneImgCell
                cell.setParams(par: dataList![indexPath.row])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.calculCellHeight(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.calculCellHeight(indexPath: indexPath)
    }
    
    // 计算cell高度
    func calculCellHeight(indexPath: IndexPath) -> CGFloat {

        let params:HotCellModel = dataList![indexPath.row]

        let three = self.isThreeImg(params: params)
        
        let cellHeight = params.cellHeight
        
        if cellHeight == nil {
            var newHeight: CGFloat
            
            if params.boardid == "video_bbs" {
                newHeight = HotVideoCell.cellHeight(text: params.title!)
            } else {
                if three {
                    newHeight = HotThreeImgCell.cellHeight(text: params.title!)
                } else {
                    newHeight = HotOneImgCell.cellHeight()
                }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scr = \(scrollView.contentOffset.y)")
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let params:HotCellModel = dataList![indexPath.row]
        if params.boardid == "news2_bbs" || params.boardid == "dy_wemedia_bbs" {
            let vc: NewsDetailsViewController = NewsDetailsViewController()
            vc.params = params
            self.rootVC?.navigationController?.pushViewController(vc , animated: true)
        }

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
