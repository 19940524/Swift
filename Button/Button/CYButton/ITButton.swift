//
//  ITButton.swift
//  Button
//
//  Created by 红鹊豆 on 2018/4/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class ITButton: CYButton {
    
    /// 图片和标题的对齐方式
    ///
    /// - left: 靠左
    /// - right: 靠右
    /// - top: 靠上
    /// - bottom: 靠下
    /// - lhCenter: 图片在左水平居中
    /// - rhCenter: 图片在右水平居中
    /// - tvCenter: 图片在上垂直居中
    /// - bvCenter: 图片在下垂直居中
    /// - lHalfAndHalf: 图片在左对半
    /// - rHalfAndHalf: 图片在右对半
    /// - leftTitleCenter: 标题靠左
    /// - rightTitleCenter: 标题靠右
    /// - topTitleCenter: 标题靠上
    /// - bottomTitleCenter: 标题靠下
    enum ITAlignment: Int {
        case left        = 0
        case right       = 1
        case top         = 2
        case bottom      = 3
        case lhCenter     = 4
        case rhCenter     = 5
        case tvCenter     = 6
        case bvCenter     = 7
        case lHalfAndHalf = 8
        case rHalfAndHalf = 9
        case leftTitleCenter    = 10
        case rightTitleCenter   = 11
        case topTitleCenter     = 12
        case bottomTitleCenter  = 13
    }
    var itAlignment : ITAlignment = .lhCenter {
        didSet {
            self.setNeedsLayout();
        }
    }
    
    /// 图片和标题间隔
    var itMargin : CGFloat = 0 {
        didSet {
            self.setNeedsLayout();
        }
    }
    
    /// 图片和标题 左右上下 设置偏移只针对一项， 居中模式无效
    var itInset : UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.setNeedsLayout();
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sWidth = self.width
        let sHeight = self.height
        // 标题最大宽度 高度
        var tMaxWidth : CGFloat = sWidth
//        var tMaxHeight : CGFloat = self.height
        
        let imageSize : CGSize = (self.imageView?.image?.size)!
        
        self.titleLabel?.sizeToFit()
        var titleSize : CGSize = (self.titleLabel?.size)!
        
        if itAlignment == .left || itAlignment == .right {
            tMaxWidth -= itInset.left + itInset.right - itMargin - imageSize.width
        }
        else if itAlignment == .bottom || itAlignment == .top ||
            itAlignment == .lhCenter || itAlignment == .rhCenter ||
            itAlignment == .tvCenter || itAlignment == .bvCenter {
            tMaxWidth -= itInset.left + itInset.right
        }
        else if itAlignment == .lHalfAndHalf || itAlignment == .rHalfAndHalf {
            tMaxWidth -= tMaxWidth / 2 - itMargin / 2
        }
        titleSize.width = min(titleSize.width, tMaxWidth)
        
        var imagePoint : CGPoint = CGPoint.zero
        var titlePoint : CGPoint = CGPoint.zero
        
        // 获取对齐方式 计算出 point
        switch itAlignment {
        case .left:
            imagePoint.x = itInset.left
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            
            titlePoint.x = imagePoint.x + imageSize.width + itMargin
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            break
        case .right:
            imagePoint.x = sWidth - itInset.right - imageSize.width
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            
            titlePoint.x = imagePoint.x - itMargin - titleSize.width
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            
            break
        case .top:
            imagePoint.y = itInset.top
            imagePoint.x = sWidth / 2 - imageSize.width / 2
            
            titlePoint.y = imagePoint.y + imageSize.height + itMargin
            titlePoint.x = sWidth / 2 - titleSize.width / 2
            break
        case .bottom:
            imagePoint.y = sHeight - itInset.bottom - imageSize.height
            imagePoint.x = sWidth / 2 - imageSize.width / 2
            
            titlePoint.y = imagePoint.y - itMargin - titleSize.height
            titlePoint.x = sWidth / 2 - titleSize.width / 2
            break
        case .lhCenter:
            let mun = imageSize.width + itMargin + titleSize.width
            imagePoint.x = sWidth / 2 - mun / 2
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            
            titlePoint.x = imagePoint.x + imageSize.width + itMargin
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            break
        case .rhCenter:
            let mun = imageSize.width + itMargin + titleSize.width
            titlePoint.x = sWidth / 2 - mun / 2
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            
            imagePoint.x = titlePoint.x + titleSize.width + itMargin
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            break
        case .tvCenter:
            let mun = imageSize.height + itMargin + titleSize.height
            imagePoint.y = sHeight / 2 - mun / 2
            imagePoint.x = sWidth / 2 - imageSize.width / 2
            
            titlePoint.y = imagePoint.y + imageSize.height + itMargin
            titlePoint.x = sWidth / 2 - titleSize.width / 2
            break
        case .bvCenter:
            let mun = imageSize.height + itMargin + titleSize.height
            titlePoint.y = sHeight / 2 - mun / 2
            titlePoint.x = sWidth / 2 - titleSize.width / 2
            
            imagePoint.y = titlePoint.y + titleSize.height + itMargin
            imagePoint.x = sWidth / 2 - imageSize.width / 2
            break
        case .lHalfAndHalf:
            imagePoint.x = sWidth / 2 - itMargin / 2 - imageSize.width
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            
            let lastW = titleSize.width
            titleSize.width = sWidth / 2 - itMargin / 2 - itInset.right
            titleSize.width = min(titleSize.width, lastW)
            
            titlePoint.x = sWidth / 2 + itMargin / 2
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            break
        case .rHalfAndHalf:
            let lastW = titleSize.width
            titleSize.width = sWidth / 2 - itMargin / 2 - itInset.left
            titleSize.width = min(titleSize.width, lastW)
            
            titlePoint.x = sWidth / 2 - itMargin / 2 - titleSize.width
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            
            imagePoint.x = sWidth / 2 + itMargin / 2
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            break
        case .leftTitleCenter:
            titlePoint.x = itInset.left
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            
            imagePoint.x = titlePoint.x + titleSize.width + itMargin
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            break
        case .rightTitleCenter:
            titlePoint.x = sWidth - itInset.right - titleSize.width
            titlePoint.y = sHeight / 2 - titleSize.height / 2
            
            imagePoint.x = titlePoint.x - itMargin - imageSize.width
            imagePoint.y = sHeight / 2 - imageSize.height / 2
            break
        case .topTitleCenter:
            titlePoint.y = itInset.top
            titlePoint.x = sWidth / 2 - titleSize.width / 2
            
            imagePoint.y = titlePoint.y + titleSize.height + itMargin
            imagePoint.x = sWidth / 2 - imageSize.width / 2
            break
        case .bottomTitleCenter:
            titlePoint.y = sHeight - itInset.bottom - titleSize.height
            titlePoint.x = sWidth / 2 - titleSize.width / 2
            
            imagePoint.y = titlePoint.y - itMargin - imageSize.height
            imagePoint.x = sWidth / 2 - imageSize.width / 2
            break
        }
        
        self.imageView?.frame = CGRect(origin: imagePoint, size: imageSize)
        self.titleLabel?.frame = CGRect(origin: titlePoint, size: titleSize)
        // 标题最大值
        
        // 获取大小
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
