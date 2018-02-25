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

class CYHomeVC: CYViewController,UIScrollViewDelegate,TopMenuViewDelegate,HotTableViewDelegate {

    private let scrollView    = UIScrollView()
    private let hotTableView  = HotTableView(frame: CGRect(), style: .plain)
    private let subCollectionView  = SubscribeCollectionView(frame: CGRect(x: CYDevice.width(),
                                                                           y: 0,
                                                                           width: CYDevice.width(),
                                                                           height: CYDevice.height() - CYDevice.navigation_h() - CYDevice.tabbar_h()))
    private let liveTableView = LiveTableView(frame: CGRect(), style: .plain)
    private let topMenuView   = TopMenuView()
    
    lazy var promptView: PromptView = { () -> PromptView in
        let view = PromptView.init(frame: CGRect(x: self.view.width/2 - 180/2, y: 0, width: 180, height: 35))
        view.alpha = 0
        self.view.addSubview(view)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.createNavigationBar(name: "ExploreSearchButton", rightSel: #selector(CYHomeVC.searchEvent))
        topMenuView.delegate = self
        self.bbNavigationBar?.addSubview(topMenuView)
        
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        
        hotTableView.hotDelegate = self
        hotTableView.rootVC = self

        scrollView.addSubview(hotTableView)
        scrollView.addSubview(subCollectionView)
        scrollView.addSubview(liveTableView)
        
    }

    // 点击顶部菜单
    func clickMenu(index: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * scrollView.width, y: 0), animated: true)
    }
    
    @objc func searchEvent() {
        var list:Array = [["name":"小三","age":"18"],["name":"小六","age":"16"],["name":"小五","age":"17"]]
        print(" 内存 ---> \(Unmanaged<AnyObject>.passUnretained(list[0] as AnyObject).toOpaque())")
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        

        let statusH = CYDevice.statusBar_h()
        let topM_H = CYDevice.navigation_h() - statusH
        topMenuView.frame = CGRect(x: (bbNavigationBar?.width)! / 2 - 140 / 2, y: statusH, width: 140, height: topM_H)
        
        scrollView.frame = CGRect(x: 0, y: (bbNavigationBar?.bottom)!,
                                  width: view.width,
                                  height: CYDevice.height() - (bbNavigationBar?.height)! - CYDevice.tabbar_h())
        
        scrollView.contentSize = CGSize(width: scrollView.width * 3, height: 0)
        
        hotTableView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        subCollectionView.frame = CGRect(x: scrollView.width, y: 0, width: scrollView.width, height: scrollView.height)
        liveTableView.frame = CGRect(x: scrollView.width * 2, y: 0, width: scrollView.width, height: scrollView.height)

        scrollView.setContentOffset(CGPoint(x: CGFloat(topMenuView.currentIndex) * scrollView.width, y: 0), animated: false)
        
        self.view.bringSubview(toFront: self.bbNavigationBar!)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topMenuView.setOffset(x: scrollView.contentOffset.x / scrollView.width)
        print(scrollView)
    }
    
    // 提示加载语
    func promptEvent(text: String) {
        
        self.promptView.left = CYDevice.width() / 2 - self.promptView.width / 2
        
        let tempTop: CGFloat = (self.bbNavigationBar?.bottom)!
        self.promptView.top = tempTop
        self.promptView.titleLabel.text = text
        
        UIView.animate(withDuration: 0.35, animations: {
            self.promptView.top = tempTop+10
            self.promptView.alpha = 1
        }) { (s) in
            UIView.animate(withDuration: 0.35, delay: 1, options: .curveLinear, animations: {
                self.promptView.top = tempTop
                self.promptView.alpha = 0
            }, completion: nil)
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

class PromptView: CYView {
    
    let titleLabel: CYLabel = { () -> CYLabel in
        let label: CYLabel = CYLabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = CYFont.system(size: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.RGBA(r: 0, g: 0, b: 0, a: 0.95)
        self.layer.cornerRadius = frame.size.height / 2
        
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.frame = CGRect.init(x: 20, y: 0, width: self.width-40, height: self.height)
        
    }
    
}

