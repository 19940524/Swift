//
//  MyView.swift
//  UI
//
//  Created by 红鹊豆 on 2018/1/31.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class MyView: UIView {

    var lastLocation: CGPoint = CGPoint()
    
    var subview1: UIView?
    var subview2: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        
        subview1 = UIView()
        subview1?.isUserInteractionEnabled = true
        subview1?.backgroundColor = UIColor.orange
        subview1?.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        self.addSubview(subview1!)
        
        subview2 = UIView()
        subview2?.isUserInteractionEnabled = true
        subview2?.backgroundColor = UIColor.cyan
        subview2?.frame = CGRect(x: 125, y: 125, width: 50, height: 50)
        self.addSubview(subview2!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t: AnyObject in touches {
            let touch: UITouch = t as! UITouch
            let touchView = touch.view
            if self == touchView {return}
            
            self.bringSubview(toFront: touchView!)
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                touchView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t: AnyObject in touches {
            let touch: UITouch = t as! UITouch
            let touchView = touch.view
            if self == touchView {return}
            
            let point = touch.location(in: self)
            print(point)
            
            if self.lastLocation == CGPoint() {
                self.lastLocation = point;
                return
            }
            var x = point.x - self.lastLocation.x
            var y = point.y - self.lastLocation.y

            
            x = (touchView?.frame.origin.x)!+x
            y = (touchView?.frame.origin.y)!+y
            
            let width = (touchView?.frame.size.width)!
            let height = (touchView?.frame.size.height)!
            
            let superWidth = self.frame.size.width
            let superHeight = self.frame.size.height
            
            if x <= 0 {x = 0}
            if y <= 0 {y = 0}
            if x + width > superWidth {x = superWidth - width}
            if y + height > superHeight {y = superHeight - height}
            
            let frame = CGRect(x: x,y: y,width: width,height: height)
            
            touchView?.frame = frame
            
            self.lastLocation = point;
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t: AnyObject in touches {
            let touch: UITouch = t as! UITouch
            let touchView = touch.view
            
            self.lastLocation = CGPoint()
            
            UIView.animate(withDuration: 0.2, animations: {
                touchView?.transform = CGAffineTransform.identity
            })
            
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
