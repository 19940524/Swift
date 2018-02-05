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

public let hcTitleFont: UIFont = CY_FONT.SFUITextAuto(size: 16.5)!

public let hcTitleColor: UIColor = TEXT_COLOR
public let hcSubTitleColor: UIColor = SUB_TEXT_COLOR


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
    var bigImg_w: CGFloat {
        get { return CYDevice.width() - CY_OFFSET.width(w: 20) * 2 }
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
        label.textColor     = hcSubTitleColor
        label.font          = CY_FONT.system(size: 10)
        return label
    }()
    lazy var titleLabel = { () -> YYLabel in
        let label = YYLabel()
        label.displaysAsynchronously = true
        label.numberOfLines = 2
        label.textColor     = hcTitleColor
        label.font          = hcTitleFont
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
    
    // 设置图片
    func setImage(imageViwe: UIImageView,url: URL) {
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter (
            size: CGSize(width: self.img_w, height: self.img_h),
            radius: 3.5
        )
        imageViwe.af_setImage(
            withURL: url,
            placeholderImage: UIImage(named: "article_html_content_loading"),
            filter: filter
        )
//        imageViwe.af_setImage(withURL: url)
    }
}
