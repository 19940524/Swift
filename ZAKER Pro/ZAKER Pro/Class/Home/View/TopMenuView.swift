//
//  TopMenuView.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

protocol TopMenuViewDelegate: class {
    func clickMenu(index: Int)
}

class TopMenuView: CYView {

    
    private let interval: CGFloat = 10
    private let hotButton = UIButton(type: .custom)
    private let subButton = UIButton(type: .custom)
    private let liveButton = UIButton(type: .custom)
    private var lastButton: UIButton?
    private let bottomLine = UIView()
    
    weak var delegate: TopMenuViewDelegate?
    
    private let buttonTag = 1900
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setButton(button: hotButton, tag: buttonTag, title: "热点")
        self.setButton(button: subButton, tag: buttonTag + 1, title: "订阅")
        self.setButton(button: liveButton, tag: buttonTag + 2, title: "直播")
        
        hotButton.isSelected = true
        lastButton = hotButton
        
        bottomLine.backgroundColor = NAV_COLOR
        self.addSubview(bottomLine)
    }
    
    func setButton(button: UIButton, tag: Int, title: String) {
        button.tag = tag
        button.titleLabel?.font = CY_FONT.SFUIText(size: 16.0)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(NAV_COLOR, for: .selected)
        button.addTarget(self, action: #selector(TopMenuView.buttonAction(button:)), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc func buttonAction(button: UIButton) {
        
        if lastButton == button { return }
        
        button.isSelected       = true
        lastButton?.isSelected  = false
        
        currentIndex = button.tag - buttonTag
        
        delegate?.clickMenu(index: currentIndex)
        
        lastButton = button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = (self.width - interval * 2) / 3
        
        hotButton.titleLabel?.sizeToFit()
        
        hotButton.frame = CGRect(x: 0, y: 0, width: width, height: self.height)
        subButton.frame = CGRect(x: width + interval, y: 0, width: width, height: self.height)
        liveButton.frame = CGRect(x: width * 2 + interval * 2, y: 0, width: width, height: self.height)
        
        bottomLine.frame = CGRect(x: (hotButton.titleLabel?.left)!, y: (hotButton.titleLabel?.bottom)! + 3, width: (hotButton.titleLabel?.width)!, height: 2)
    }
    
    func setOffset(x: CGFloat) {
        let left = hotButton.titleLabel?.left
        let distance = left! * 2 + (hotButton.titleLabel?.width)! + interval
        
        var newLeft = left! + distance * x
        if newLeft < left! {
            newLeft = left!
        }
        if newLeft > liveButton.left + left!  {
            newLeft = liveButton.left + left!
        }
        bottomLine.left = newLeft
        
        print(x)
        
        if bottomLine.center.x == hotButton.center.x || x < 0.1 {
            self.setCurrentIndex(index: 0)
        } else if bottomLine.center.x == subButton.center.x || (x > 0.9 && x < 1.1) {
            self.setCurrentIndex(index: 1)
        } else if bottomLine.center.x == liveButton.center.x || x > 1.9 {
            self.setCurrentIndex(index: 2)
        }
        
//        if currentIndex == 0 {
//            if x > 0.9 {
//                self.setCurrentIndex(index: 1)
//            }
//        } else if currentIndex == 1 {
//            if x > 1.9 {
//                self.setCurrentIndex(index: 2)
//            } else if x < 0.1 {
//                self.setCurrentIndex(index: 0)
//            }
//        } else {
//            if x < 1.1 {
//                self.setCurrentIndex(index: 1)
//            }
//        }
        print(currentIndex)
    }
    
    func setCurrentIndex(index: Int) {
        currentIndex = index
        lastButton?.isSelected = false
        if index == 0 {
            hotButton.isSelected = true
            lastButton = hotButton
        } else if index == 1 {
            subButton.isSelected = true
            lastButton = subButton
        } else {
            liveButton.isSelected = true
            lastButton = liveButton
        }
        
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

}
