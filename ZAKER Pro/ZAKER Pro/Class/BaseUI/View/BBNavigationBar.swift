//
//  BBNavigationBar.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/1/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class BBNavigationBar: CYView {
    
    private let blurView = UIToolbar()
    var bottomLine: UIImageView?
    
    var _titleLabel: UILabel?
    var titleLabel: UILabel? {
        get {
            if _titleLabel == nil {
                _titleLabel = UILabel()
            }
            return _titleLabel
        }
        set {
            _titleLabel = newValue
        }
    }
    
    
    var barStyle = UIBarStyle.default {
        willSet {
            print(newValue)
            blurView.barStyle = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
        
    }
    
    func initialize() {
        self.frame = CGRect(x: 0, y: 0, width: CYDevice.width(), height: CYDevice.navigation_h())
        
        self.addSubview(blurView)
        
        self.titleLabel?.font = UIFont(name: ".SFUIText-Semibold", size: 17) ?? UIFont()
        self.titleLabel?.textAlignment = .center
        self.addSubview(self.titleLabel!)
        
        self.bottomLine = UIImageView()
        self.bottomLine?.image = UIImage(named: "nav_line")
        self.addSubview(self.bottomLine!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blurView.frame = self.bounds
        bottomLine?.frame = CGRect(x: 0, y: CYDevice.navigation_h()-0.5, width: CYDevice.width(), height: 0.5)
        
        if _titleLabel != nil {
            self.titleLabel?.sizeToFit()
            let statusH = CYDevice.statusBar_h()
            let navH = CYDevice.isPortrait() ? 44.0 : 32.0
            let y = CGFloat(navH / 2.0) - ((titleLabel?.frame.size.height)! / 2.0) + statusH
            
            titleLabel?.frame.origin = CGPoint(x: CYDevice.width()/2-(titleLabel?.frame.size.width)!/2, y: y)
        }
        
    }
    
    
    
    
//    backgroundColor = UIColor.red
//    frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
