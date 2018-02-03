//
//  HotBaseCell.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/3.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class HotBaseCell: CYTableViewCell {
    
    var t_left: CGFloat {
        get {
            return CY_OFFSET.width(w: 20)
        }
    }
    var t_w: CGFloat {
        get {
            return CYDevice.width() - CY_OFFSET.width(w: 55) - ((CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3)
        }
    }
    var img_sp: CGFloat {
        get {
            return CY_OFFSET.width(w: 7)
        }
    }
    var img_w: CGFloat {
        get {
            return (CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3
        }
    }
    var img_h: CGFloat {
        get {
            return 71.0 / 107.0 * ((CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3)
        }
    }
    var img_top: CGFloat {
        get {
            return CY_OFFSET.height(h: 22)
        }
    }
    var titleTop: CGFloat {
        get {
            return CY_OFFSET.height(h: 24)
        }
    }
    var sToT_sp: CGFloat {
        get {
            return CY_OFFSET.height(h: 8)
        }
    }
    
    lazy var soucreLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor     = SUB_TEXT_COLOR
        label.font          = CY_FONT.SFUITextAuto(size: 10)
        return label
    }()
    lazy var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor     = TEXT_COLOR
        label.font          = CY_FONT.SFUITextAuto(size: 16.5)
        return label
    }()
    lazy var subTitleLabel = { () -> UILabel in
        let label = UILabel()
        label.font          = CY_FONT.SFUITextAuto(size: 10)
        return label
    }()
    lazy var coverImage = { () -> UIImageView in
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    let bottomLine = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bottomLine.backgroundColor = SPLIT_LINE_COLOR
        self.contentView .addSubview(bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.frame = CGRect(x: self.t_left, y: self.height - 0.5, width: CYDevice.width()-self.t_left*2, height: 0.5)
    }
    
    func calculateTitleHeight(width: CGFloat,text: String) -> CGFloat {
        let labelSize = text.boundingRect(with: CGSize(width: width,height: 800),
                                          options: .usesLineFragmentOrigin,
                                          attributes: [NSAttributedStringKey.font: self.titleLabel.font], context: nil)
        return labelSize.height;
    }
}

class HotOneImgCell: HotBaseCell {
    
    private var params: JSON?
    
    static let cellHeight = 71.0 / 107.0 * ((CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3) + CY_OFFSET.height(h: 22) * 2 + 1
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.coverImage)
        self.contentView.addSubview(self.soucreLabel)
        self.contentView.addSubview(self.subTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setParams(par:JSON?) {
        self.params = par
        if par == nil {
            return
        }
        self.titleLabel.text  = par?["title"].string
        self.soucreLabel.text = par?["source"].string
        
        let url = URL(string: (par?["img"].string)!)
        
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter (
            size: CGSize(width: self.img_w, height: self.img_h),
            radius: 5.0
        )
        
        self.coverImage.af_setImage(
            withURL: url!,
            placeholderImage: nil,
            filter: filter
        )
        
        let replyCount = par?["replyCount"].number
        if replyCount != nil {
            if replyCount == 0 {
                self.subTitleLabel.text = par?["ptime"].string
                self.subTitleLabel.textColor = self.soucreLabel.textColor
            } else {
                self.subTitleLabel.text = "\(replyCount!)"
                self.subTitleLabel.textColor = self.titleLabel.textColor
            }
        } else {
            self.subTitleLabel.text = par?["ptime"].string
            self.subTitleLabel.textColor = self.soucreLabel.textColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.frame = CGRect(x: self.t_left,
                                       y: self.titleTop,
                                       width: self.t_w,
                                       height: calculateTitleHeight(width: self.t_w, text: self.titleLabel.text!))
        
        self.coverImage.top   = self.img_top
        self.coverImage.size  = CGSize(width: self.img_w, height: self.img_h)
        self.coverImage.right = CYDevice.width() - self.t_left
        
        self.soucreLabel.top = self.titleLabel.bottom + self.sToT_sp
        self.soucreLabel.left = self.t_left
        self.soucreLabel.sizeToFit()
        
        self.subTitleLabel.top = self.soucreLabel.top
        self.subTitleLabel.left = self.soucreLabel.right + self.sToT_sp
        self.subTitleLabel.sizeToFit()
    }
    
    func calculateCellHeight() -> CGFloat {
        return self.img_h + self.img_top * 2 + 1
    }
    
}
