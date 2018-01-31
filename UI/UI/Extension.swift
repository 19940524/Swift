//
//  Extension.swift
//  UI
//
//  Created by 红鹊豆 on 2018/1/30.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

extension UIDevice {
//    public func isX() -> Bool {
//        if UIScreen.main.bounds.height == 812 {
//            return true
//        }
//        return false
//    }
    
    
//    public func isPortrait() -> Bool {
//        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
//            print("Landscape")
//        }
//        
//        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
//            print("Portrait")
//        }
//        return false
//    }
}

class CYDevice {
    // 判断是否iPhone X
    static func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
    // 判断是否竖屏
    static func isPortrait() -> Bool {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            return false
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            return true
        }
        return false
    }
    // 屏幕宽度
    static func width() -> CGFloat {
        
        return UIScreen.main.bounds.width
    }
    // 屏幕高度
    static func height() -> CGFloat {
        
        return UIScreen.main.bounds.height
    }
    // 导航栏高度
    static func navHeight() -> CGFloat {
        // 系统横屏的高度 为 32
        let height = CGFloat(self.isPortrait() ? (self.isX() ? 88 : 64) : 32)
        
        return height
    }
    
}


