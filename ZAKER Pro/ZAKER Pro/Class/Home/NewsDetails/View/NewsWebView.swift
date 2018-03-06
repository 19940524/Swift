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
    public var superScrollView: UIScrollView? {
        didSet {
            superScrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: &myContext)
        }
    }
    
    public var imageUrls: Array<String>? = Array()
    public var imgDetalis: Array<Dictionary<String, String>>? = nil
    var imageOriginY: Array<CGFloat>? = Array()
    let imageTag: Int = 4000
    
    private var myContext = 0
    
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
//        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if !webLoadFinish {
            webView.evaluateJavaScript("document.body.getBoundingClientRect().height", completionHandler: { [weak self] (obj, error) in
                let number: NSNumber = obj as! NSNumber
//                print(number)
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
        imageUrls?.removeAll()
        
        for view in self.scrollView.subviews {
            if view.isMember(of: CYImageView.self) {
                view.removeFromSuperview()
            }
        }
        
        let imgs = self.imgDetalis
        let count:Int = (imgs?.count)!
        for i in 0..<count {
            let imgParams = imgs![i]
            let divIdName: String = "guobinImageID\(i)"
            imageUrls?.append(imgParams["src"]!)
            
            self.getDivFrame(name: divIdName, complated: { [weak self] (divFrame) in
                
//                print(divFrame)
                
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
                
                let offsetY: CGFloat = (self?.scrollView.contentOffset.y)! + (CYDevice.height()-40)
                if divFrame.origin.y < offsetY {
                    imageView.bb_setImage(withURL: URL(string: imgParams["src"]!)!)
                }
            })
        }
    }
    
    
    @objc func clickPhoto(sender: UITapGestureRecognizer) {
        self.newsDelegate?.clickPhoto(webView: self, urls: imageUrls!, selIndex: (sender.view?.tag)! - imageTag)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myContext {
            if let newValue: CGPoint = (change?[NSKeyValueChangeKey.newKey] as! CGPoint) {
                
//                CGFloat y = [newVal CGPointValue].y + scrollView.height;
//                [wSelf scrollContentOffsetY:y];
                let y = newValue.y + (superScrollView?.height)!
                self.scrollContentOffsetY(offsetY: y)
            }
        }
    }
    
    func scrollContentOffsetY(offsetY: CGFloat) {
        
        let queue = DispatchQueue.global()
        queue.async {
            
            let tempYList: Array = self.imageOriginY!
            let imgs     : Array = self.imgDetalis!
            
            
            for i in 0..<tempYList.count {
                let currentImageY: CGFloat = tempYList[i]
                if i >= imgs.count { break }
                
                let imgParams: Dictionary = imgs[i]
                
                if currentImageY < offsetY && currentImageY > offsetY - (self.superScrollView?.height)!  {
                    
                    DispatchQueue.main.sync {
                        
                        let tag = self.imageTag + i
                        print("tag = \(tag)")
                        let imageView: CYImageView? = self.scrollView.viewWithTag(tag) as? CYImageView
//                        imageView?.bb_setImage(withURL: URL(string: imgParams["src"]!)!)
                        imageView?.af_setImage(withURL: URL(string: imgParams["src"]!)!)
                    }
                }
                
                
            }
            
        }
        
        // iOS10 下部分空白 布局更新就好了
        self.setNeedsLayout()
    }
    
    func startGIF() {
        guard self.imgDetalis?.count != 0 else {
            return
        }
        let imgs     : Array = self.imgDetalis!
        for i in 0..<imgs.count {
            let tag = self.imageTag + i
            
            let imageView: CYImageView? = self.scrollView.viewWithTag(tag) as? CYImageView
            imageView?.startAnimating()
        }
        
    }
    
    func stopGIF() {
        guard self.imgDetalis?.count != 0 else {
            return
        }
        let imgs     : Array = self.imgDetalis!
        for i in 0..<imgs.count {
            let tag = self.imageTag + i
            
            let imageView: CYImageView? = self.scrollView.viewWithTag(tag) as? CYImageView
            imageView?.stopAnimating()
        }
    }
    
    deinit {
        superScrollView?.removeObserver(self, forKeyPath: "contentOffset", context: &myContext)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.stopGIF()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.startGIF()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }
    
}










