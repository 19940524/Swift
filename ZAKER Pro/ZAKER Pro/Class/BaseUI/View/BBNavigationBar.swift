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
    
    // 左item懒加载
    var _leftItme: UIButton?
    lazy var leftItem = { () -> UIButton in
        _leftItme = UIButton(type: .custom)
        self.addSubview(_leftItme!)
        return _leftItme!
    }()

    var _rightItem: UIButton?
    lazy var rightItem = { () -> UIButton in
        _rightItem = UIButton(type: .custom)
        self.addSubview(_rightItem!)
        return _rightItem!
    }()
    
    // 标题
    
     var titleLabel = UILabel()
    
    // 模糊样式
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
        
        self.titleLabel.font = SYS_FONT ?? UIFont()
        self.titleLabel.textAlignment = .center
        self.addSubview(self.titleLabel)
        
        self.bottomLine = UIImageView()
//        self.bottomLine?.image = UIImage(named: "nav_line")
        self.bottomLine?.backgroundColor = SPLIT_LINE_COLOR
        self.addSubview(self.bottomLine!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setSubviewFrame()
    }
    
    func setSubviewFrame() {
        blurView.frame = self.bounds
        bottomLine?.frame = CGRect(x: 0, y: CYDevice.navigation_h()-0.5, width: CYDevice.width(), height: 0.5)
        
        if  titleLabel.text != nil {
            self.titleLabel.sizeToFit()
            let statusH = CYDevice.statusBar_h()
            let navH = CYDevice.isPortrait() ? 44.0 : 32.0
            let y = CGFloat(navH / 2.0) - ((titleLabel.frame.size.height) / 2.0) + statusH
            
            titleLabel.frame.origin = CGPoint(x: CYDevice.width()/2-(titleLabel.frame.size.width) / 2, y: y)
        }
        
        if _leftItme != nil {
            let WH = CYDevice.navigation_h() - CYDevice.statusBar_h()
            _leftItme?.frame = CGRect(x: CGFloat(0.0), y: CYDevice.statusBar_h(), width: WH, height: WH)
        }
        
        if _rightItem != nil {
            let WH = CYDevice.navigation_h() - CYDevice.statusBar_h()
            _rightItem?.frame = CGRect(x: CYDevice.width()-WH, y: CYDevice.statusBar_h(), width: WH, height: WH)
        }
    }
    
    public func setText(title: String?) {
        self.titleLabel.text = title
        self.setSubviewFrame()
    }
    
    

    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
