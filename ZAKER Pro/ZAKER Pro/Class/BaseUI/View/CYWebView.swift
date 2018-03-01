//
//  CYWebView.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/25.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import WebKit

class CYWebView: WKWebView {
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension WKWebView {
    
    /// 获取 div 距离上边距的Y
    func getDivTop(name: String, complated:@escaping (CGFloat) -> ()) {
        let jsString: String = "document.getElementById(\"\(name)\").offsetTop;"
        self.evaluateJavaScript(jsString) { [weak self] (obj, error) in
            self?.complatedMethods(obj: obj, complated: complated)
        }
    }
    
    /// 获取 div 距离左边距的X
    func getDivLeft(name: String, complated:@escaping (CGFloat) -> ()) {
        let jsString: String = "document.getElementById(\"\(name)\").offsetLeft;"
        self.evaluateJavaScript(jsString) { [weak self] (obj, error) in
            self?.complatedMethods(obj: obj, complated: complated)
        }
    }
    
    /// 获取 div 宽度
    func getDivWidth(name: String, complated:@escaping (CGFloat) -> ()) {
        let jsString: String = "document.getElementById(\"\(name)\").offsetWidth;"
        self.evaluateJavaScript(jsString) { [weak self] (obj, error) in
            self?.complatedMethods(obj: obj, complated: complated)
        }
    }
    
    /// 获取 div 高度
    func getDivHeight(name: String, complated:@escaping (CGFloat) -> ()) {
        let jsString: String = "document.getElementById(\"\(name)\").offsetHeight;"
        self.evaluateJavaScript(jsString) { [weak self] (obj, error) in
            self?.complatedMethods(obj: obj, complated: complated)
        }
    }

    func getDivFrame(name: String, complated:@escaping (CGRect) -> ()) {
        
        var elementOffsetLeft   : CGFloat = 0;
        var elemnrtOffsetTop    : CGFloat = 0;
        var elementWidth        : CGFloat = 0;
        var elementHeight       : CGFloat = 0;

        self.getDivLeft(name: name) { [weak self] (left) in
            elementOffsetLeft = left
            self?.getDivTop(name: name, complated: { [weak self] (top) in
                elemnrtOffsetTop = top
                self?.getDivWidth(name: name, complated: { [weak self] (width) in
                    elementWidth = width
                    self?.getDivHeight(name: name, complated: { (height) in
                        elementHeight = height
                        complated(CGRect(x: elementOffsetLeft, y: elemnrtOffsetTop, width: elementWidth, height: elementHeight))
                    })
                })
            })
        }
    }
    
    func getDiv(x: CGFloat, y: CGFloat) {
        let jsString: String = "document.elementFromPoint(\(x),\(y);"
        self.evaluateJavaScript(jsString) {  (obj, error) in
            print(obj ?? "获取不到 div")
        }
    }
    
    func complatedMethods(obj: Any?,complated:@escaping (CGFloat) -> ()) {
        DispatchQueue.main.async {
            if obj != nil {
                let number: NSNumber = obj as! NSNumber
                complated(CGFloat(number.floatValue))
            } else {
                complated(0)
            }
        }
    }
    
    
}









