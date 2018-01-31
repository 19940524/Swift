//
//  Extensions.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/1/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

let nbTag = 1600

extension UIViewController {
    
    
    
    var bbNavigationBar: BBNavigationBar? {
        var view: BBNavigationBar? = nil
        if self.view.viewWithTag(nbTag) != nil {
            view = (self.view.viewWithTag(nbTag) as! BBNavigationBar)
            if self.title != nil {
                view?.titleLabel?.text = self.title
            }
        }
        return view
    }
    
    
    @discardableResult
    func createNavigationBar() -> BBNavigationBar {
        
        let navigationBar = BBNavigationBar()
        navigationBar.tag = nbTag
        self.view.addSubview(navigationBar)
        
        return navigationBar
    }
    
    
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
    static func navigation_h() -> CGFloat {
        // 系统横屏的高度 为 32
        let height = CGFloat(self.isPortrait() ? (self.isX() ? 88 : 64) : 32)
        
        return height
    }
    

    static func statusBar_h() -> CGFloat {
        return self.isPortrait() ? (self.isX() ? 44 : 20) : 0
    }
    
}
