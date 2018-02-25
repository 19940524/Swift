//
//  HotThreeImgCell.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/5.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

/// 三图
class HotThreeImgCell: HotBaseCell {
    private var params: HotCellModel?
    private let imageView1: CYImageView = CYImageView()
    private let imageView2: CYImageView = CYImageView()
    private let imageView3: CYImageView = CYImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imageView1)
        self.contentView.addSubview(imageView2)
        self.contentView.addSubview(imageView3)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.soucreLabel)
        self.contentView.addSubview(self.subTitleLabel)
        
        imageView1.clipsToBounds = true
        imageView2.clipsToBounds = true
        imageView3.clipsToBounds = true
        imageView1.contentMode = UIViewContentMode.scaleAspectFill
        imageView2.contentMode = UIViewContentMode.scaleAspectFill
        imageView3.contentMode = UIViewContentMode.scaleAspectFill
        
    }
    
    func setParams(par:HotCellModel?) {
        self.params = par
        if par == nil {
            return
        }

        self.titleLabel.text  = par?.title
        self.soucreLabel.text = par?.source
        
        let url = URL(string:  (par?.img!)!)
        self.setImage(imageViwe: imageView1, url: url!)
        
        let imgs:Array<String> = (par?.imgnewextra!)!
        let imgurl2:URL = URL(string: imgs[0])!
        self.setImage(imageViwe: imageView2, url: imgurl2)
        let imgurl3:URL = URL(string: imgs[1])!
        self.setImage(imageViwe: imageView3, url: imgurl3)
        
        self.subTitleLabel.attributedText = par?.subTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        self.subTitleLabel.size = CalculateText.attSize(text: (params?.subTitle)!, width: 300)
        self.subTitleLabel.bottom = self.soucreLabel.bottom
        self.subTitleLabel.bottom -= (self.params?.isShowTime)! ? 1.5 : 0
        
        self.imageView1.frame = CGRect(x: self.t_left, y: self.soucreLabel.bottom + CY_OFFSET.height(h: 12), width: self.img_w, height: self.img_h)
        self.imageView2.frame = CGRect(x: self.t_left+self.img_sp+self.img_w, y: self.imageView1.top, width: self.img_w, height: self.img_h)
        self.imageView3.frame = CGRect(x: self.t_left+self.img_sp * 2 + self.img_w * 2, y: self.imageView1.top, width: self.img_w, height: self.img_h)
    }
    
    static func cellHeight(text: String) -> CGFloat {
        
        let tW: CGFloat = CYDevice.width() - CY_OFFSET.width(w: 20) * 2
        let imgI: CGFloat = CY_OFFSET.width(w: 7) * 2
        let imgW: CGFloat = (71.0 / 107.0 * (tW - imgI) / 3)
        let topB: CGFloat = CY_OFFSET.height(h: 22) * 2 + 1
        let tH: CGFloat = CalculateText.height(width: tW, text: text, font: hcTitleFont)
        let cellHeight =  tH + CY_OFFSET.height(h: 30) + imgW + topB
        return cellHeight
    }
    
    
}
