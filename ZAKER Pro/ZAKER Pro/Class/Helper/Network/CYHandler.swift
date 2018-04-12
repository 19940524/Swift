//
//  CYHandler.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/12.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias Success = (Any) -> ()
typealias Failed  = (Any) -> ()

class CYHandler: NSObject {

    static func GETData(url: String, params: Dictionary<String, Any>?,success: Success?, failed: Failed?) {
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            //            print(response.request!)  // 原始的URL请求
            //            print(response.response ?? "response error") // HTTP URL响应
            //            print(response.data ?? "error")     // 服务器返回的数据
            print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
                        if response.error == nil {
                            let jsonData = JSON.init(response.data!)
                            if success != nil {
                                success!(jsonData)
                            }
                        } else {
                            if failed != nil {
                                failed!(response.error!)
                                print("\n-----------网络请求失败")
                                print(response.error!)
                            }
            }
            
        }
        
    }
    
}
