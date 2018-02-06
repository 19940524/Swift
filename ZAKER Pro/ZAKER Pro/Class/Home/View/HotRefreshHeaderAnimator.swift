//
//  HotRefreshHeaderAnimator.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/6.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class HotRefreshHeaderAnimator: CYView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var duration: TimeInterval = 0.3
    public var trigger: CGFloat = 56.0
    public var executeIncremental: CGFloat = 56.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private let baseView: UIView = UIView()
    private let centerView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerView.backgroundColor = UIColor.white
        baseView.backgroundColor   = UIColor.RGB(r: 216, g: 216, b: 216)
        
        
        self.addSubview(baseView)
        baseView.addSubview(centerView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func refreshAnimationBegin(view: ESRefreshComponent) {
        print("动画开始")
    }
    
    func refreshAnimationEnd(view: ESRefreshComponent) {
        print("动画结束")
    }
    
    func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        print("正在刷新  \(progress)")
    }
    
    func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        print(" state  \(state)")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
