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
    
    public var imageUrls: Array<String>? = nil
    public var imgDetalis: Array<Dictionary<String, String>>? = nil
    var imageOriginY: Array<CGFloat>? = Array()
    let imageTag: Int = 4000
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setParams() {
        self.isOpaque = false
        self.navigationDelegate = self
        self.backgroundColor = UIColor.white
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
                self?.height = CGFloat(number.floatValue) + 40
                self?.newsDelegate?.updateWebCellHegiht(webView: self!)
            })
        }
        
        webLoadFinish = true
        
        self.updateContentImageFrame()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("webview error")
    }
    
    func updateContentImageFrame() {
        imageOriginY?.removeAll()
        
        for view in self.scrollView.subviews {
            if view.isMember(of: CYImageView.self) {
                view.removeFromSuperview()
            }
        }
        
        let imgs = self.imgDetalis
        
        var i: Int = 0
        for imgParams in imgs! {
            let divIdName: String = "guobinImageID\(i)"
            
            self.getDivFrame(name: divIdName, complated: { [weak self] (divFrame) in
                
                print(divFrame)
                
                let imageView: CYImageView = CYImageView()
                imageView.isUserInteractionEnabled = true
                imageView.contentMode = .scaleAspectFit
                imageView.tag = (self?.imageTag)! + i
                imageView.frame = divFrame
                self?.scrollView.addSubview(imageView)

                let y: CGFloat = divFrame.origin.y
                if self?.imageOriginY?.contains(y) == false {
                    self?.imageOriginY?.append(y)
                }

                let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewsWebView.clickPhoto(sender:)))
                imageView.addGestureRecognizer(tapGR)

                if divFrame.origin.y < (self?.scrollView.contentOffset.y)! + (self?.scrollView.frame.size.height)! {
                    imageView.bb_setImage(withURL: URL(string: imgParams["src"]!)!)
                }
            })
            
            i += 1
        }
        
        
    }
    
    
    @objc func clickPhoto(sender: UITapGestureRecognizer) {
        print(sender.view!)
    }
    
    
    
    
    
    
    
    
}










