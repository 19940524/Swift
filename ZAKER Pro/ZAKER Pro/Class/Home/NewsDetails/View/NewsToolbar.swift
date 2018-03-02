//
//  NewsToolbar.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/3/2.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit


protocol NewsToolbarBBDelegate {
    func popViewController()
}

class NewsToolbar: CYView {
    
    let topLine: CYView = CYView();
    let backButton    : CYButton = CYButton(type: .custom)
    let shareButton   : CYButton = CYButton(type: .custom)
    let commentButton : CYButton = CYButton(type: .custom)
    let replyButton   : CYButton = CYButton(type: .custom)
    let moreButton    : CYButton = CYButton(type: .custom)
    
    var bbDelegate: NewsToolbarBBDelegate? = nil
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        
        topLine.backgroundColor = SPLIT_LINE_COLOR;
        self.addSubview(topLine)
        
        self.setButton(button: backButton,    tag: 1300, image: UIImage(named: "addRootBlock_toolbar_return")!)
        self.setButton(button: shareButton,   tag: 1301, image: UIImage(named: "common_icon_share")!)
        self.setButton(button: commentButton, tag: 1302, image: UIImage(named: "icon_comment")!)
        self.setButton(button: replyButton,   tag: 1303, image: UIImage(named: "icon_pl")!)
        self.setButton(button: moreButton,    tag: 1304, image: UIImage(named: "common_icon_more")!)
        
    }
    
    func setButton(button: CYButton, tag: NSInteger,image: UIImage) {
        button.tag = tag;
        
        if tag != 1303 {
            button.imageView?.tintColor = UIColor.RGB(r: 92, g: 92, b: 92)
            button.setImage(image.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
            if tag == 1302 {
                let w: CGFloat = CYDevice.width() / 5
                let h: CGFloat = 40
                let tb: CGFloat = 6.5
                let lr: CGFloat = w / h * tb
                button.imageEdgeInsets = .init(top: tb+1, left: lr, bottom: tb-1, right: lr)
            }
        } else {
            button.setImage(image, for: .normal)
        }
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(NewsToolbar.buttonAction(button:)), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc func buttonAction(button: CYButton) {
        switch button.tag {
        case 1300:
            self.bbDelegate?.popViewController()
            break
        case 1301:
            break
            
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topLine.frame = CGRect(x: 0, y: 0, width: self.width, height: 0.5)
        
        for tag in 1300..<1305 {
            let index: CGFloat = CGFloat(tag) - 1300
            let button = self.viewWithTag(tag)
            let bW: CGFloat = self.width / 5
            let bH: CGFloat = self.height
            button?.frame = CGRect(x: index * bW, y: 0, width: bW, height: bH)
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
