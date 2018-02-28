//
//  NewsWebView.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/25.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import WebKit

protocol NewsWebDelegate: class {
    func updateWebCellHegiht(webView: NewsWebView)
    func webLoadFinishUpdateOthersData(webView: NewsWebView)
    func clickPhoto(webView: NewsWebView,urls: Array<String>,selIndex: NSInteger)
}

class NewsWebView: CYWebView, WKNavigationDelegate {

    weak var newsDelegate: NewsWebDelegate?
    public var webLoadFinish: Bool = false
    
    public var htmlString: String?
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setParams() {
        self.isOpaque = false
        self.navigationDelegate = self
        self.scrollView.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if !webLoadFinish {
            webView.evaluateJavaScript("document.body.getBoundingClientRect().height", completionHandler: { [weak self] (obj, error) in
                let number: NSNumber = obj as! NSNumber
                print(number)
                self?.height = CGFloat(number.floatValue)
                self?.newsDelegate?.updateWebCellHegiht(webView: self!)
            })
        }
        
        webLoadFinish = true
    }
    
    
}
