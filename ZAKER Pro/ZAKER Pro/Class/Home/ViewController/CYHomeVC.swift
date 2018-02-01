//
//  CYHomeViewController.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/1/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class CYHomeVC: CYViewController,UIScrollViewDelegate,TopMenuViewDelegate {

    private let scrollView    = UIScrollView()
    private let hotTableView  = HotTableView(frame: CGRect(), style: .plain)
    private let subTableView  = SubscribeTableView(frame: CGRect(), style: .plain)
    private let liveTableView = LiveTableView(frame: CGRect(), style: .plain)
    private let topMenuView   = TopMenuView()
    
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
        
        
        
    }

    // 点击顶部菜单
    func clickMenu(index: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * scrollView.width, y: 0), animated: true)
    }
    
    @objc func searchEvent() {
        self.title = "123"
    }
    
    
    var changeValue: Int? = nil
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        

        let statusH = CYDevice.statusBar_h()
        let topM_H = CYDevice.navigation_h() - statusH
        topMenuView.frame = CGRect(x: (bbNavigationBar?.width)! / 2 - 140 / 2, y: statusH, width: 140, height: topM_H)
        
        
        // 转屏是 处理滚动视图 偏移量偏差
        let offsetValue = scrollView.contentOffset.x / scrollView.width
        if !offsetValue.isNaN {
            let indexValue = Int(offsetValue)
            if CGFloat(indexValue) == offsetValue {
                changeValue = indexValue
            }
        }
        
        scrollView.frame = CGRect(x: 0, y: (bbNavigationBar?.bottom)!,
                                  width: view.width,
                                  height: CYDevice.height() - (bbNavigationBar?.height)! - CYDevice.tabbar_h())
        
        scrollView.contentSize = CGSize(width: scrollView.width * 3, height: scrollView.height)
        
        hotTableView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        subTableView.frame = CGRect(x: scrollView.width, y: 0, width: scrollView.width, height: scrollView.height)
        liveTableView.frame = CGRect(x: scrollView.width * 2, y: 0, width: scrollView.width, height: scrollView.height)
        

        // 转屏是 处理滚动视图 偏移量偏差
        if changeValue != nil {
            scrollView.setContentOffset(CGPoint(x: CGFloat(changeValue!) * scrollView.width, y: 0), animated: true)
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeValue = nil
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
