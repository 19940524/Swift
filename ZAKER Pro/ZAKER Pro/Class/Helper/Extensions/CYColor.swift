//
//  CYColor.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/6.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

extension UIColor {
    static func RGB(r: CGFloat,g: CGFloat,b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    static func RGBA(r: CGFloat,g: CGFloat,b: CGFloat,a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    static func random() -> UIColor {
        let r:CGFloat = CGFloat(Random.range(from: 1..<255))
        let g:CGFloat = CGFloat(Random.range(from: 1..<255))
        let b:CGFloat = CGFloat(Random.range(from: 1..<255))
        
        return UIColor.RGB(r: r, g: g, b: b)
    }
}
