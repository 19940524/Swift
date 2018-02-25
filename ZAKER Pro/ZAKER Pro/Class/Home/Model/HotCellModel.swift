//
//  HotCellModel.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/5.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

class HotCellModel: CYCellModel {
    
    var title       : String?       //  标题
    var source      : String?       //  作者
    var subTitle    : NSMutableAttributedString?       //  副标题 有评论显示 无显示时间
    var prompt      : String?       //  “成功为您推荐10条新内容” 的提示语
    var ptime       : String?       //  发布时间
    var replyCount  : String?       //  评论
    var img         : String?       //  图片
    var imgnewextra : Array<String>?
    var boardid     : String?       // photoview_bbs  图集 news2_bbs       新闻 video_bbs      视频 dy_wemedia_bbs  新闻
    var digest      : String?       // 描述
    var isShowTime  : Bool?
    
    override init() {
        super.init()
        
    }
    func setParams(params:JSON) {
        
        for (key,value) in params {
//            print(key,value)
            if key == "title" {
                title = value.string
                continue
            }
            if key == "source" {
                source = value.string
                continue
            }
            if key == "prompt" {
                prompt = value.string
                continue
            }
            if key == "ptime" {
                ptime = value.string
                continue
            }
            if key == "replyCount" {
                replyCount = "\(value.number ?? 0)"
                continue
            }
            if key == "img" {
                img = value.string
                continue
            }
            if key == "imgnewextra" {
                imgnewextra = Array()
                let imgs:Array = value.array!
                for v:JSON in imgs {
                    let url: String = v["imgsrc"].string!
                    imgnewextra?.append(url)
                }
                continue
            }
            if key == "boardid" {
                boardid = value.string
                continue
            }
            if key == "digest" {
                digest = value.string
                continue
            }
            
        }
        if replyCount != nil {
            if Int(replyCount!) == 0 {
                if self.ptime == nil {
                    self.subTitle = NSMutableAttributedString(string: "刚刚")
                    isShowTime = true
                } else {
                    self.setTimeText(time: self.ptime)
                }
            } else {
                self.setReplyText(reply: self.replyCount!)
            }
        } else {
            if self.ptime == nil {
                self.subTitle = NSMutableAttributedString(string: "刚刚")
            } else {
                self.setTimeText(time: self.ptime)
            }
        }
        
    }
    
    // 设置时间
    func setTimeText(time: String?) {
        isShowTime = true
        
        if time == nil {
            self.subTitle = nil
            return
        }
        let regionRome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italianItaly)
        // 基于自定义时间格式解析时间字符串
        let date = DateInRegion(string: time!, format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: regionRome)
        
        var dateTime: String = (date?.colloquialSinceNow())!
        dateTime = dateTime.replacingOccurrences(of: "后", with: "前")
        
        let text: NSMutableAttributedString = NSMutableAttributedString(string: dateTime)
        let range: NSRange = NSRange(location: 0, length: text.string.count)
        text.yy_setColor(hcSubTitleColor, range:  range)
        text.yy_setFont(CYFont.system(size: 10), range: range)
        self.subTitle = text
    }
    // 设置评论
    func setReplyText(reply: String) {
        isShowTime = false
        let text: NSMutableAttributedString = NSMutableAttributedString(string: "\(reply)评论")
        var range: NSRange = NSRange(location: text.string.count-2, length: 2)
        text.yy_setColor(hcTitleColor, range:  range)
        text.yy_setFont(CYFont.system(size: 12), range: range)
        let countStr: String = "\(reply)"
        range = NSRange(location: 0, length: countStr.count)
        text.yy_setFont(CYFont.system(size: 10), range: range)
        self.subTitle = text
    }
    
}



























