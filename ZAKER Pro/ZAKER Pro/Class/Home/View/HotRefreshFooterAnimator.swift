//
//  HotRefreshFooterAnimator.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/13.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class HotRefreshFooterAnimator: ESRefreshFooterView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var trigger: CGFloat = 42.0
    public var executeIncremental: CGFloat = 42.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    open var loadingMoreDescription: String = "更多..."
    open var noMoreDataDescription: String  = "没有更多数据了"
    open var loadingDescription: String     = "正在加载..."
    
    fileprivate let titleLabel: UILabel = {

        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    var point1: CYView?
    var point2: CYView?
    var point3: CYView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = loadingMoreDescription
        self.addSubview(titleLabel)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPoints() {
        point1 = CYView()
        point2 = CYView()
        point3 = CYView()
        
        self.addSubview(point1!)
        self.addSubview(point2!)
        self.addSubview(point3!)
        
        point1!.alpha = 0
        point2!.alpha = 0
        point3!.alpha = 0
        point1!.layer.cornerRadius = 2
        point2!.layer.cornerRadius = 2
        point3!.layer.cornerRadius = 2
        point1!.backgroundColor = UIColor.gray
        point2!.backgroundColor = UIColor.gray
        point3!.backgroundColor = UIColor.gray
        point1!.size = CGSize(width: 4, height: 4)
        point2!.size = CGSize(width: 4, height: 4)
        point3!.size = CGSize(width: 4, height: 4)
    }
    
    func removePoints() {
        point1?.removeFromSuperview()
        point2?.removeFromSuperview()
        point3?.removeFromSuperview()
    }
    
    
    func refreshAnimationBegin(view: ESRefreshComponent) {
        
    }
    
    func refreshAnimationEnd(view: ESRefreshComponent) {
        
    }
    
    func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        print(progress)
    }
    
    func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        self.state = state
        titleLabel.isHidden = false
        self.removePoints()
        
        switch state {
        case .refreshing :
            titleLabel.isHidden = true
            self.showPoints()
            
            break
        case .autoRefreshing :
            titleLabel.text = loadingDescription
            break
        case .noMoreData:
            titleLabel.text = noMoreDataDescription
            break
        default:
            titleLabel.text = loadingMoreDescription
            break
        }
    }
    
    func showPoints() {
        self.addPoints()
        
        self.startAnimate()
    }
    
    func startAnimate() {
        
        if self.state == .refreshing {
            self.fAnimate()
            self.sAnimate()
            self.tAnimate()
        }
        
        
    }
    
    func fAnimate() {
        point1!.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveLinear, animations: {
            self.point1!.alpha = 1
        }) { (s) in
            
            UIView.animate(withDuration: 0.6, animations: {
                self.point1!.alpha = 0
            }, completion: { (su) in

            })
        }
    }
    
    func sAnimate() {
        point2!.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveLinear, animations: {
            self.point2!.alpha = 1
        }) { (s) in
            
            UIView.animate(withDuration: 0.6, animations: {
                self.point2!.alpha = 0
            }, completion: { (su) in

            })
        }
    }
    
    func tAnimate() {
        point3!.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.4, options: .curveLinear, animations: {
            self.point3!.alpha = 1
        }) { (s) in
            
            UIView.animate(withDuration: 0.6, animations: {
                self.point3!.alpha = 0
            }, completion: { (su) in
                self.startAnimate()
            })
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.size = CGSize.init(width: 320, height: self.height)
        titleLabel.center = CGPoint.init(x: self.width/2, y: self.height/2)
        
        point2?.center = self.center
        point1?.top = point2!.top
        point1?.right = point2!.left - 5
        
        point3?.top = point2!.top
        point3?.left = point2!.right + 5
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
