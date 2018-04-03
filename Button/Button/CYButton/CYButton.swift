//
//  CYButton.swift
//  Button
//
//  Created by 红鹊豆 on 2018/4/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class CYButton: UIButton {
    
    /// 设置圆角图片
    public func setRoundImage(
        image : UIImage?,
        for state : UIControlState) {
        if image == nil { return }
        
        self.setImage(image?.cornerImage(), for: state)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
