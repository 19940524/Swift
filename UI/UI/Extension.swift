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
    static func width() -> Int {
        print(Int(UIScreen.main.bounds.width))
        let width = Int(UIScreen.main.bounds.width)
        return width
    }
    // 屏幕高度
    static func height() -> Int {
        print(Int(UIScreen.main.bounds.height))
        let height = Int(UIScreen.main.bounds.height)
        return height
    }
    // 导航栏高度
    static func navHeight() -> Int {
        
        let height = (self.isPortrait() ? (self.isX() ? 88 : 64) : 44)
        
        return height
    }
    
}


