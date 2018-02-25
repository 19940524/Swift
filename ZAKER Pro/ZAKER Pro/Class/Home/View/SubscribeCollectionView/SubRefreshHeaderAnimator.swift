//
//  SubRefreshHeaderAnimator.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/18.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class SubRefreshHeaderAnimator: CYView, ESRefreshProtocol, ESRefreshAnimatorProtocol {

    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var duration: TimeInterval = 0.3
    public var trigger: CGFloat = 60.0
    public var executeIncremental: CGFloat = 60.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    public var arrowTop: Bool = false
    
    open var downDescription: String    = "下拉可以出现封面"
    open var loadingDescription: String = "松开即可出现封面"
    
    fileprivate let titleLabel: UILabel = {
        
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let imageView: CYImageView = {
        let view = CYImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = downDescription
        self.addSubview(titleLabel)
        
        imageView.image = UIImage.init(named: "RefreshControlArrowBlackNoBottom")
        self.addSubview(imageView)
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
//                print("正在刷新  \(y)")
        
        if y > 60 {
            titleLabel.text = loadingDescription
            
            if arrowTop { return }
            arrowTop = true
            self.animation()
        } else {
            titleLabel.text = downDescription
            
            if !arrowTop { return }
            arrowTop = false
            self.animation()
        }
    }
    
    func animation()  {
        
        UIView.animate(withDuration: 0.1) {
            self.imageView.transform = self.arrowTop ? .init(rotationAngle: Conversion.degreesToRadians(angle:  180)) : .identity
        }
    }
    
    func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        self.state = state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        titleLabel.origin = CGPoint.init(x: self.width/2 - titleLabel.width/2, y: self.height/2)
        
        imageView.size = CGSize.init(width: 15, height: 15)
        imageView.top  = self.height / 2 - 15
        imageView.left = self.width/2 - 7.5
    }
    
}
