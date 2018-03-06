//
//  CYTableView.swift
//  CYViewController
//
//  Created by 红鹊豆 on 2018/1/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class CYTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func customScrollBar(image: UIImage) {
        
        for view in self.subviews {
            
            if view.isMember(of: UIImageView.self) {
                let w = view.width
                let h = view.height
                let r = CGFloat.minimum(w, h)
                if r == w {
                    view.setValue(image, forKey: "image")
                }
            }
        }
        
    }
    
}
