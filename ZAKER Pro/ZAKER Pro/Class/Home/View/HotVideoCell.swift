//
//  HotVideoCell.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/5.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class HotVideoCell: HotBaseCell {

    private var params: HotCellModel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.coverImage)
        self.contentView.addSubview(self.soucreLabel)
        self.contentView.addSubview(self.subTitleLabel)
        
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
        
        let url = URL(string:  (par?.img!)!)
        self.setImage(imageViwe: self.coverImage, url: url!)
        
        self.subTitleLabel.attributedText = par?.subTitle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var titleFrame: CGRect? = params?.titleFrame
        if titleFrame == nil {
            let tW: CGFloat = CYDevice.width() - CY_OFFSET.width(w: 20) * 2
            let titleH = CalculateText.height( width: tW, text: self.titleLabel.text!, font: self.titleLabel.font)
            titleFrame = CGRect(x: self.t_left, y: self.img_top, width: tW, height: titleH)
            params?.titleFrame = titleFrame
        }
        self.titleLabel.frame = titleFrame!
        
        
        var sourceFrame: CGRect? = params?.standbyFrame
        if sourceFrame == nil {
            let size = CalculateText.size(text: self.soucreLabel.text!, font: self.soucreLabel.font)
            sourceFrame = CGRect(x: self.t_left, y: self.titleLabel.bottom + self.sToT_sp, width: size.width, height: size.height)
            params?.standbyFrame = sourceFrame
        }
        self.soucreLabel.frame = sourceFrame!
        
        self.subTitleLabel.left = self.soucreLabel.right + self.sToT_sp
        self.subTitleLabel.size = CGSize(width: 100, height: 20)
        self.subTitleLabel.centerY = self.soucreLabel.centerY
        
        self.coverImage.frame = CGRect(x: self.t_left, y: self.subTitleLabel.bottom + CY_OFFSET.height(h: 8), width: self.bigImg_w, height: 9.0 / 16.0 * self.bigImg_w)
        
    }
    
    static func cellHeight(text: String) -> CGFloat {
        
        let tW: CGFloat = CYDevice.width() - CY_OFFSET.width(w: 20) * 2
        let imgH: CGFloat = 9.0 / 16.0 * tW
        let topB: CGFloat = CY_OFFSET.height(h: 22) * 2 + 1
        let tH: CGFloat = CalculateText.height(width: tW, text: text, font: hcTitleFont)
        let cellHeight =  tH + CY_OFFSET.height(h: 15) + 20 + imgH + topB
        return cellHeight
    }

}
