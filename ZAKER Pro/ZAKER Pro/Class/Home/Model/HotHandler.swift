//
//  HotHandler.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/12.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HotHandler: CYHandler {
    
    static func GETHotHData(fn: Int, success: Success?,failed: Failed?) {
        
        let url = "https://c.m.163.com/recommend/getSubDocPic?from=toutiao&prog=Rpic2&open=&openpath=&passport=WznDdjHz22nrm57NxuzNqZ2WxSDQJdPl%2BJwBqzUqSejL2AgtwrES0PPiPHJrLH2UePBK0dNsyevylzp8V9OOiA%3D%3D&devId=JmnpPZswyTEcbyrMfmsPJVb%2B/H3cH95XF1nu8XmVs9FL6BGnxStm2K1yNLf5aRZn&version=32.0&spever=false&net=wifi&lat=&lon=&ts=1517570676&sign=LDiDqDKIv5U27gW/1UAmU4OxFktUXUk7ZShaI7feJe548ErR02zJ6/KXOnxX046I&encryption=1&canal=appstore&offset=0&size=10&fn=\(fn)&spestr=shortnews"
        
        CYHandler.GETData(url: url, params: nil, success: success, failed: failed)
    }
    
    static func GETHotFData(offset: Int,fn: Int, success: Success?,failed: Failed?) {
        
        let url = "https://c.m.163.com/recommend/getSubDocPic?from=toutiao&prog=Rpic2&open=&openpath=&passport=WznDdjHz22nrm57NxuzNqZ2WxSDQJdPl%2BJwBqzUqSejL2AgtwrES0PPiPHJrLH2UePBK0dNsyevylzp8V9OOiA%3D%3D&devId=JmnpPZswyTEcbyrMfmsPJVb%2B/H3cH95XF1nu8XmVs9FL6BGnxStm2K1yNLf5aRZn&version=32.0&spever=false&net=wifi&lat=&lon=&ts=1517570676&sign=LDiDqDKIv5U27gW/1UAmU4OxFktUXUk7ZShaI7feJe548ErR02zJ6/KXOnxX046I&encryption=1&canal=appstore&offset=\(offset)&size=10&fn=\(fn)&spestr=shortnews"
        
        CYHandler.GETData(url: url, params: nil, success: success, failed: failed)
    }
    
}
