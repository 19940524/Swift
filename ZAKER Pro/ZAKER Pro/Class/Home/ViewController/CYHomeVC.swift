//
//  CYHomeViewController.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/1/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CYHomeVC: CYViewController,UIScrollViewDelegate,TopMenuViewDelegate {

    private let scrollView    = UIScrollView()
    private let hotTableView  = HotTableView(frame: CGRect(), style: .plain)
    private let subTableView  = SubscribeTableView(frame: CGRect(), style: .plain)
    private let liveTableView = LiveTableView(frame: CGRect(), style: .plain)
    private let topMenuView   = TopMenuView()
    private let hotUrl        = "https://c.m.163.com/recommend/getSubDocPic?from=toutiao&prog=Rpic2&open=&openpath=&passport=WznDdjHz22nrm57NxuzNqZ2WxSDQJdPl%2BJwBqzUqSejL2AgtwrES0PPiPHJrLH2UePBK0dNsyevylzp8V9OOiA%3D%3D&devId=JmnpPZswyTEcbyrMfmsPJVb%2B/H3cH95XF1nu8XmVs9FL6BGnxStm2K1yNLf5aRZn&version=32.0&spever=false&net=wifi&lat=&lon=&ts=1517570676&sign=LDiDqDKIv5U27gW/1UAmU4OxFktUXUk7ZShaI7feJe548ErR02zJ6/KXOnxX046I&encryption=1&canal=appstore&offset=0&size=10&fn=0&spestr=shortnews"
    private var tidList: Array<Dictionary<String, Any>>?
    
//    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createNavigationBar(name: "ExploreSearchButton", rightSel: #selector(CYHomeVC.searchEvent))
        topMenuView.delegate = self
        self.bbNavigationBar?.addSubview(topMenuView)
        
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(hotTableView)
        scrollView.addSubview(subTableView)
        scrollView.addSubview(liveTableView)
        
        // 网络暂时这样写 以后自己写
        Alamofire.request("\(hotUrl)/get").responseJSON { response in
//            print(response.request!)  // 原始的URL请求
//            print(response.response ?? "response error") // HTTP URL响应
//            print(response.data ?? "error")     // 服务器返回的数据
            print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
            if response.error == nil {
                let jsonData = JSON.init(response.data!)
//                print(jsonData["tid"])
                var newList: Array<HotCellModel> = Array()
                for params in jsonData["tid"].arrayValue {
                    let model:HotCellModel = HotCellModel()
                    model.setParams(params: params)
                    newList.append(model)
                }
                self.hotTableView.dataList = newList
            }
        }
        
    }

    // 点击顶部菜单
    func clickMenu(index: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * scrollView.width, y: 0), animated: true)
    }
    
    @objc func searchEvent() {
        
        
        var list:Array = [["name":"小三","age":"18"],["name":"小六","age":"16"],["name":"小五","age":"17"]]
        print(" 内存 ---> \(Unmanaged<AnyObject>.passUnretained(list[0] as AnyObject).toOpaque())")
        print(" 内存 ---> \(Unmanaged<AnyObject>.passUnretained(list[1] as AnyObject).toOpaque())")
        print(" 内存 ---> \(Unmanaged<AnyObject>.passUnretained(list[2] as AnyObject).toOpaque())")
        
        var s: Dictionary = list[0]
        var l: Dictionary = list[1]
        var w: Dictionary = list[2]
        
        print("s 内存 ---> \(Unmanaged<AnyObject>.passUnretained(s as AnyObject).toOpaque())")
        print("l 内存 ---> \(Unmanaged<AnyObject>.passUnretained(l as AnyObject).toOpaque())")
        print("w 内存 ---> \(Unmanaged<AnyObject>.passUnretained(w as AnyObject).toOpaque())")
        
        s["age"] = "19";
        l["age"] = "17";
        w["age"] = "18";
        
        print("s 内存 ---> \(Unmanaged<AnyObject>.passUnretained(s as AnyObject).toOpaque())")
        print("l 内存 ---> \(Unmanaged<AnyObject>.passUnretained(l as AnyObject).toOpaque())")
        print("w 内存 ---> \(Unmanaged<AnyObject>.passUnretained(w as AnyObject).toOpaque())")
        
        print(" 内存 ---> \(Unmanaged<AnyObject>.passUnretained(list[0] as AnyObject).toOpaque())")
        print(" 内存 ---> \(Unmanaged<AnyObject>.passUnretained(list[1] as AnyObject).toOpaque())")
        print(" 内存 ---> \(Unmanaged<AnyObject>.passUnretained(list[2] as AnyObject).toOpaque())")
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        

        let statusH = CYDevice.statusBar_h()
        let topM_H = CYDevice.navigation_h() - statusH
        topMenuView.frame = CGRect(x: (bbNavigationBar?.width)! / 2 - 140 / 2, y: statusH, width: 140, height: topM_H)
        
        scrollView.frame = CGRect(x: 0, y: (bbNavigationBar?.bottom)!,
                                  width: view.width,
                                  height: CYDevice.height() - (bbNavigationBar?.height)! - CYDevice.tabbar_h())
        
        scrollView.contentSize = CGSize(width: scrollView.width * 3, height: scrollView.height)
        
        hotTableView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        subTableView.frame = CGRect(x: scrollView.width, y: 0, width: scrollView.width, height: scrollView.height)
        liveTableView.frame = CGRect(x: scrollView.width * 2, y: 0, width: scrollView.width, height: scrollView.height)

        scrollView.setContentOffset(CGPoint(x: CGFloat(topMenuView.currentIndex) * scrollView.width, y: 0), animated: false)
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topMenuView.setOffset(x: scrollView.contentOffset.x / scrollView.width)
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
