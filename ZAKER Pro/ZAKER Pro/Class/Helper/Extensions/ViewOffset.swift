//
//  ViewOffset.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

extension UIView {
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            self.left = newValue - self.width
        }
    }
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            self.top = newValue - self.height
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            return self.frame = CGRect(origin: self.frame.origin, size: newValue)
        }
    }
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    
    
}
