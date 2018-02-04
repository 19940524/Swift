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
import YYText
import SwiftDate

private let titleFont: UIFont = CY_FONT.SFUITextAuto(size: 16.5)!

class HotBaseCell: CYTableViewCell {
    
    var t_left: CGFloat {
        get { return CY_OFFSET.width(w: 20) }
    }
    var t_w: CGFloat {
        get { return CYDevice.width() - CY_OFFSET.width(w: 55) - ((CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3) }
    }
    var img_sp: CGFloat {
        get { return CY_OFFSET.width(w: 7) }
    }
    var img_w: CGFloat {
        get { return (CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3 }
    }
    var img_h: CGFloat {
        get { return 71.0 / 107.0 * ((CYDevice.width() - CY_OFFSET.width(w: 20) * 2 - CY_OFFSET.width(w: 7) * 2) / 3) }
    }
    var img_top: CGFloat {
        get { return CY_OFFSET.height(h: 22) }
    }
    var titleTop: CGFloat {
        get { return CY_OFFSET.height(h: 24) }
    }
    var sToT_sp: CGFloat {
        get { return CY_OFFSET.height(h: 8) }
    }
    
    lazy var soucreLabel = { () -> YYLabel in
        let label = YYLabel()
        label.displaysAsynchronously = true
        label.textColor     = SUB_TEXT_COLOR
        label.font          = CY_FONT.system(size: 10)
        return label
    }()
    lazy var titleLabel = { () -> YYLabel in
        let label = YYLabel()
        label.displaysAsynchronously = true
        label.numberOfLines = 2
        label.textColor     = TEXT_COLOR
        label.font          = titleFont
        return label
    }()
    lazy var subTitleLabel = { () -> YYLabel in
        let label = YYLabel()
        label.displaysAsynchronously = true
        label.font          = CY_FONT.system(size: 10)
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
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
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
    // 设置时间
    func setTimeText(time: String?) {
        if time == nil {
            self.subTitleLabel.attributedText = nil
            return
        }
        let regionRome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italianItaly)
        // 基于自定义时间格式解析时间字符串
        let date = DateInRegion(string: time!, format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: regionRome)
        
        var dateTime: String = (date?.colloquialSinceNow())!
        dateTime = dateTime.replacingOccurrences(of: "后", with: "前")
        
        let text: NSMutableAttributedString = NSMutableAttributedString(string: dateTime)
        let range: NSRange = NSRange(location: 0, length: text.string.count)
        text.yy_setColor(self.soucreLabel.textColor, range:  range)
        text.yy_setFont(CY_FONT.system(size: 10), range: range)
        self.subTitleLabel.attributedText = text
        self.subTitleLabel.textColor = self.soucreLabel.textColor
    }
    // 设置评论
    func setReplyText(replyCount: NSNumber) {
        let text: NSMutableAttributedString = NSMutableAttributedString(string: "\(replyCount)评论")
        var range: NSRange = NSRange(location: text.string.count-2, length: 2)
        text.yy_setColor(self.titleLabel.textColor, range:  range)
        text.yy_setFont(CY_FONT.system(size: 12), range: range)
        let countStr: String = "\(replyCount)"
        range = NSRange(location: 0, length: countStr.count)
        text.yy_setFont(CY_FONT.system(size: 10), range: range)
        self.subTitleLabel.attributedText = text
        self.subTitleLabel.textColor = self.titleLabel.textColor
    }
    // 设置图片
    func setImage(imageViwe: UIImageView,url: URL) {
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter (
            size: CGSize(width: self.img_w, height: self.img_h),
            radius: 3.5
        )
        imageViwe.af_setImage(
            withURL: url,
            placeholderImage: nil,
            filter: filter
        )
//        imageViwe.af_setImage(withURL: url)
    }
}


/// 单图cell
class HotOneImgCell: HotBaseCell {
    
    private var params: JSON?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func setParams(par:JSON?) {
        self.params = par
        if par == nil {
            return
        }
        self.titleLabel.text  = par?["title"].string
        self.soucreLabel.text = par?["source"].string
        
        let url = URL(string: (par?["img"].string)!)
        self.setImage(imageViwe: coverImage, url: url!)
        
        let replyCount = par?["replyCount"].number
        if replyCount != nil {
            if replyCount == 0 {
                self.setTimeText(time: par?["ptime"].string)
            } else {
                self.setReplyText(replyCount: replyCount!)
            }
        } else {
            self.setTimeText(time: par?["ptime"].string)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleH = CalculateText.height(
            width: self.t_w,
            text: self.titleLabel.text!,
            font: self.titleLabel.font
        )
        self.titleLabel.frame = CGRect(x: self.t_left, y: self.titleTop, width: self.t_w, height: titleH)

        self.coverImage.frame = CGRect(x: CYDevice.width()-self.t_left-self.img_w, y: self.img_top, width: self.img_w, height: self.img_h)
        
        let size: CGSize = CalculateText.size(text: self.soucreLabel.text!, font: self.soucreLabel.font)
        self.soucreLabel.frame = CGRect(x: self.t_left, y: self.titleLabel.bottom + self.sToT_sp, width: size.width, height: size.height)
        
        self.subTitleLabel.left = self.soucreLabel.right + self.sToT_sp
        self.subTitleLabel.size = CGSize(width: 100, height: 20)
        self.subTitleLabel.centerY = self.soucreLabel.centerY
    }
}

class HotThreeImgCell: HotBaseCell {
    private var params: JSON?
    private let imageView1: UIImageView = UIImageView()
    private let imageView2: UIImageView = UIImageView()
    private let imageView3: UIImageView = UIImageView()
    
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
    
    func setParams(par:JSON?) {
        self.params = par
        if par == nil {
            return
        }
        self.titleLabel.text  = par?["title"].string
        self.soucreLabel.text = par?["source"].string
        
        let url = URL(string: (par?["img"].string)!)
        self.setImage(imageViwe: imageView1, url: url!)
        
        let imgs:Array<JSON> = (par?["imgnewextra"].array)!
        let imgurl2:URL = URL(string: imgs[0]["imgsrc"].string!)!
        self.setImage(imageViwe: imageView2, url: imgurl2)
        let imgurl3:URL = URL(string: imgs[1]["imgsrc"].string!)!
        self.setImage(imageViwe: imageView3, url: imgurl3)
        
        let replyCount = par?["replyCount"].number
        if replyCount != nil {
            if replyCount == 0 {
                self.setTimeText(time: par?["ptime"].string)
            } else {
                self.setReplyText(replyCount: replyCount!)
            }
        } else {
            self.setTimeText(time: par?["ptime"].string)
        }
        
        let tW: CGFloat = CYDevice.width() - CY_OFFSET.width(w: 20) * 2
        let titleH = CalculateText.height(
            width: tW,
            text: self.titleLabel.text!,
            font: self.titleLabel.font
        )
        self.titleLabel.frame = CGRect(x: self.t_left, y: self.img_top, width: tW, height: titleH)
        
        self.soucreLabel.top = self.titleLabel.bottom + self.sToT_sp
        self.soucreLabel.left = self.t_left
        self.soucreLabel.size = CalculateText.size(text: self.soucreLabel.text!, font: self.soucreLabel.font)
        
        self.subTitleLabel.left = self.soucreLabel.right + self.sToT_sp
        self.subTitleLabel.size = CGSize(width: 100, height: 20)
        self.subTitleLabel.centerY = self.soucreLabel.centerY
        
        self.imageView1.frame = CGRect(x: self.t_left, y: self.soucreLabel.bottom + CY_OFFSET.height(h: 12), width: self.img_w, height: self.img_h)
        self.imageView2.frame = CGRect(x: self.t_left+self.img_sp+self.img_w, y: self.imageView1.top, width: self.img_w, height: self.img_h)
        self.imageView3.frame = CGRect(x: self.t_left+self.img_sp * 2 + self.img_w * 2, y: self.imageView1.top, width: self.img_w, height: self.img_h)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    static func cellHeight(text: String) -> CGFloat {

        let tW: CGFloat = CYDevice.width() - CY_OFFSET.width(w: 20) * 2
        let imgI: CGFloat = CY_OFFSET.width(w: 7) * 2
        let imgW: CGFloat = (71.0 / 107.0 * (tW - imgI) / 3)
        let topB: CGFloat = CY_OFFSET.height(h: 22) * 2 + 1
        let tH: CGFloat = CalculateText.height(width: tW, text: text, font: titleFont)
        let cellHeight =  tH + CY_OFFSET.height(h: 20) + 20 + imgW + topB
        return cellHeight
    }
    
    
}
