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
    
    private let baseMaxWH: CGFloat = 22
    private let baseView: UIView = UIView()
    private let centerView: CYImageView = CYImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerView.image = UIImage.init(named: "whitePoint")
        baseView.backgroundColor   = UIColor.RGB(r: 216, g: 216, b: 216)
        
        
        self.addSubview(baseView)
        baseView.addSubview(centerView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func refreshAnimationBegin(view: ESRefreshComponent) {
//        print("动画开始")
    }
    
    func refreshAnimationEnd(view: ESRefreshComponent) {
//        print("动画结束")
    }
    
    func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        
        let y: CGFloat = progress * trigger
//        print("正在刷新  \(y)")
        
        
        let oTop: CGFloat = 17
        
        var baseSize:   CGFloat = 0
        var baseY:      CGFloat = oTop
        var centerSize: CGFloat = 0
        
        if y >= oTop && y <= baseMaxWH + oTop {
            baseSize = y - oTop
            baseY = trigger - oTop - baseSize
            baseView.layer.cornerRadius = baseSize / 2
            
            centerSize = baseSize / 2
            
        } else if y > baseMaxWH + oTop  {
            baseSize = baseMaxWH
            centerSize = baseSize / 2
            baseView.layer.cornerRadius = baseSize / 2
        }
        
        baseView.frame = CGRect(x: self.width/2 - baseSize/2, y: baseY, width: baseSize, height: baseSize)
        centerView.frame = CGRect(x: baseView.width / 2 - centerSize / 2,
                                  y: baseView.height / 2 - centerSize / 2,
                                  width: centerSize,
                                  height: centerSize)
    }
    
    func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        self.state = state
        
        if state == .refreshing {
            self.magnifyCenter()
        } else if state == .pullToRefresh {
            
        }
    }
    
    // 放大
    func magnifyCenter() {
        let centerSize: CGFloat = baseMaxWH * 0.8
        let centerXY:   CGFloat = baseMaxWH/2 - centerSize/2
        
        UIView.animate(withDuration: 0.05, delay: 0.1, options: .curveLinear, animations: {
            if self.state == .refreshing {
                self.centerView.frame = CGRect(x: centerXY, y: centerXY, width: centerSize, height: centerSize)
            }
        }) { (succeed) in
            if self.state == .refreshing {
                self.shrinkCenter()
            }
        }
    }
    
    // 缩小
    func shrinkCenter() {
        let minSize: CGFloat = self.baseMaxWH * 0.25
        let minXY:   CGFloat = self.baseMaxWH/2 - minSize/2
        UIView.animate(withDuration: 0.48, delay: 0.1, options: .curveLinear, animations: {
            if self.state == .refreshing {
                self.centerView.frame = CGRect(x: minXY, y: minXY, width: minSize, height: minSize)
            }
        }) { (succeed) in
            if self.state == .refreshing {
                self.magnifyCenter()
            }
        }
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
