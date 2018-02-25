//
//  HotOneImgCell.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/5.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

/// 单图cell
class HotOneImgCell: HotBaseCell {
    
    private var params: HotCellModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.contentView.backgroundColor = UIColor.red
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.coverImage)
        self.contentView.addSubview(self.soucreLabel)
        self.contentView.addSubview(self.subTitleLabel)
    }
    
    static func cellHeight() -> CGFloat {
        let cellHeight = 71.0 / 107.0 * ((CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3) + CY_OFFSET.height(h: 22) * 2 + 1
        return cellHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setParams(par:HotCellModel?) {
        self.params = par
        if par == nil {
            return
        }
        
        self.titleLabel.text  = par?.title
        self.soucreLabel.text = par?.source
        
        if par?.img != nil {
            let url = URL(string:  (par?.img!)!)
            self.setImage(imageViwe: coverImage, url: url!)            
        }
        
        
        self.subTitleLabel.attributedText = par?.subTitle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var titleFrame: CGRect? = params?.titleFrame
        if titleFrame == nil {
            let titleH = CalculateText.height( width: self.t_w, text: self.titleLabel.text!, font: self.titleLabel.font )
            titleFrame = CGRect(x: self.t_left, y: self.titleTop, width: self.t_w, height: titleH)
            params?.titleFrame = titleFrame
        }
        self.titleLabel.frame = titleFrame!
        
        self.coverImage.frame = CGRect(x: CYDevice.width()-self.t_left-self.img_w, y: self.img_top, width: self.img_w, height: self.img_h)
        
        var sourceFrame: CGRect? = params?.standbyFrame
        if sourceFrame == nil {
            let size: CGSize = CalculateText.size(text: self.soucreLabel.text!, font: self.soucreLabel.font)
            sourceFrame = CGRect(x: self.t_left, y: self.titleLabel.bottom + self.sToT_sp, width: size.width, height: size.height)
            params?.standbyFrame = sourceFrame
        }
        self.soucreLabel.frame = sourceFrame!
        
        self.subTitleLabel.left = self.soucreLabel.right + self.sToT_sp
        self.subTitleLabel.size = CalculateText.attSize(text: (params?.subTitle)!, width: 300)
        self.subTitleLabel.bottom = self.soucreLabel.bottom
        
        self.subTitleLabel.bottom -= (self.params?.isShowTime)! ? 1.5 : 0
    }
}
