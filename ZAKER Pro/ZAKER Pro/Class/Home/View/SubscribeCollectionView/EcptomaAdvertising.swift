//
//  EcptomaAdvertising.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/18.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

protocol FmImageViewDelegate {
    func removeView()
    func backLocation()
}

class FmImageView: CYImageView {
    
    private var lastY: CGFloat = 0
    public var delegate: FmImageViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage.init(named: "fmbg.jpeg");
        self.isUserInteractionEnabled = true
        self.contentMode = .scaleAspectFill
        
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGRAction(sender:)))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panGRAction(sender: UIPanGestureRecognizer) {
        
        if sender.state == .began {
            lastY = 0;
        }
        
        let point: CGPoint = sender.translation(in: self)
        let y: CGFloat = point.y
        
        if sender.state == .changed {
            if y < 0 {
                let newY = self.height - abs(y)
                if newY <= self.height && y < lastY {
                    print(newY)
                    self.top = newY
                }
                lastY = y
            }
        }
        
        if sender.state == .ended {
            guard lastY != 0 else {
                return
            }
            
            if abs(y) > self.height * 0.16 {
                self.delegate?.removeView()
            } else {
                self.delegate?.backLocation()
            }
        }
    }
    
}

class EcptomaAdvertising: NSObject, UICollisionBehaviorDelegate,FmImageViewDelegate {
    
    private var baseView: CYView? = CYView()
    
    private var dynamicAnimator: UIDynamicAnimator? = nil
    private var imageView: FmImageView = FmImageView(frame: CGRect.zero)
    
    override init() {
        super.init()
    }
    
    func show() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let w: UIWindow = delegate.window!
        
        baseView?.frame = CGRect(x: 0, y: -w.height, width: w.width, height: w.height * 2)
        w.addSubview(baseView!)
        
        baseView?.superview?.bringSubview(toFront: baseView!)
        imageView.delegate = self
        imageView.frame = CGRect(x: 0, y: 0, width: (baseView?.width)!, height: (baseView?.height)! / 2)
        baseView?.addSubview(imageView)
        
        self.setGraviteAnimation()
    }
    
    func setGraviteAnimation() {
        
        dynamicAnimator = UIDynamicAnimator(referenceView: baseView!)
        //重力行为
        let gravite = UIGravityBehavior(items: [imageView])
        //加速度
        gravite.magnitude = 9
        //碰撞行为
        let collisionBehavior = UICollisionBehavior(items: [imageView])
        //用参考视图边界作为碰撞边界
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        
        let hugeBehavior = UIDynamicItemBehavior(items: [imageView])
        //弹性
        hugeBehavior.elasticity = 1
        hugeBehavior.friction = 0;
        hugeBehavior.density = 0.0
        //阻力
        hugeBehavior.resistance = 0.0
        
        dynamicAnimator?.addBehavior(gravite)
        dynamicAnimator?.addBehavior(collisionBehavior)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
            self.dynamicAnimator?.removeAllBehaviors()
        }
    }
    
    @objc func buttonAction(button: CYButton) {
        
        baseView?.removeFromSuperview()
    }
    
    // MARK: - FmImageViewDelegate
    func removeView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.top = 0
        }) { (f) in
            self.baseView?.removeFromSuperview()
        }
    }
    
    func backLocation() {
        UIView.animate(withDuration: 0.15, animations: {
            self.imageView.top = self.imageView.height
        }) { (f) in
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
