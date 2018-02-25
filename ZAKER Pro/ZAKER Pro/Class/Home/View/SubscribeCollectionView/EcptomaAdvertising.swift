//
//  EcptomaAdvertising.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/18.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class EcptomaAdvertising: NSObject, UICollisionBehaviorDelegate {
    
    private var baseView: CYView? = nil
    
    private var dynamicAnimator: UIDynamicAnimator? = nil
    
    override init() {
        super.init()
    }
    
    func show() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let w: UIWindow = delegate.window!
        baseView = CYView()
        baseView?.frame = CGRect(x: 0, y: -w.height, width: w.width, height: w.height * 2)
        baseView?.backgroundColor = UIColor.clear
        w.addSubview(baseView!)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: baseView!)
        
        baseView?.superview?.bringSubview(toFront: baseView!)
        
        let button: CYButton = CYButton(frame: CGRect(x: 0, y: 0, width: baseView!.width, height: baseView!.height / 2))
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(EcptomaAdvertising.buttonAction(button:)), for: .touchUpInside)
        baseView?.addSubview(button)
        
        //重力行为
        let gravite = UIGravityBehavior(items: [button])
        //加速度
        gravite.magnitude = 17
        //碰撞行为
        let collisionBehavior = UICollisionBehavior(items: [button])
        //用参考视图边界作为碰撞边界
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        
        let hugeBehavior = UIDynamicItemBehavior(items: [button])
        //弹性
        hugeBehavior.elasticity = 1
        //阻力
        hugeBehavior.resistance = 0.1
        
        dynamicAnimator?.addBehavior(gravite)
        dynamicAnimator?.addBehavior(collisionBehavior)
    }
    
    @objc func buttonAction(button: CYButton) {
        
        baseView?.removeFromSuperview()
    }
    
}
