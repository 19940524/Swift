//
//  Extensions.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/1/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

struct CY_FONT {
    static func SFUIText(size: CGFloat) -> UIFont? {
        return UIFont(name: ".SFUIText-Semibold", size: size)
    }

    static func SFUITextAuto(size: CGFloat) -> UIFont? {
        return UIFont(name: ".SFUIText-Semibold", size: size * CYDevice.width() / 375)
    }
    
    static func systemAuto(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size * CYDevice.width() / 375)
    }
    static func system(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}

struct CY_OFFSET {
    static func width(w: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width / 375.0 * w
    }
    static func height(h: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height / 667.0 * h
    }
}

private let max: CGFloat = 999999.0
struct CalculateText {
    
    static func height(width: CGFloat,text: String,font: UIFont) -> CGFloat {
        let labelSize = text.boundingRect(with: CGSize(width: width,height: font.lineHeight*2+10),
                                          options: .usesLineFragmentOrigin,
                                          attributes: [NSAttributedStringKey.font: font], context: nil)
        return labelSize.height+10;
    }
    static func width(height: CGFloat,text: String,font: UIFont) -> CGFloat {
        let labelSize = text.boundingRect(with: CGSize(width: max,height: height),
                                          options: .usesLineFragmentOrigin,
                                          attributes: [NSAttributedStringKey.font: font], context: nil)
        return labelSize.width;
    }
    
    static func size(text: String,font: UIFont) -> CGSize {
        let labelSize: CGSize = text.boundingRect(with: CGSize(width: max,height: max),
                                                  options: .usesLineFragmentOrigin,
                                                  attributes: [NSAttributedStringKey.font: font], context: nil).size
        return labelSize
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
    
    static func tabbar_h() -> CGFloat {
        return CGFloat(self.isPortrait() ? (self.isX() ? 83 : 49) : 32)
    }
    
}
