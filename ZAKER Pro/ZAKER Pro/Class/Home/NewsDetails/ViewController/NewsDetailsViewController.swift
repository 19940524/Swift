//
//  NewsDetailsViewController.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/25.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class NewsDetailsViewController: CYViewController, UITableViewDataSource, UITableViewDelegate,NewsWebDelegate {

    public var params:HotCellModel? = nil
    
    private var webView: NewsWebView? = nil
    private var webViewHeight: CGFloat = 200
    
    //在控制器定义全局的可变data，用户存储接收的数据
    var jsonData:NSMutableData = NSMutableData()
    var dataSoucre: Dictionary<String, Any>? {
        didSet {
            self.loadHTML()
        }
        
    }
    let bottomBarH: CGFloat = 40
    
    
    private let tableView: CYTableView = CYTableView(frame: CGRect.zero, style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.asynchronousGet()
        
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell?.contentView.backgroundColor = UIColor.red
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            var headerView: UITableViewHeaderFooterView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView")
            if headerView == nil {
                headerView = UITableViewHeaderFooterView(reuseIdentifier: "headerView")
                webView = NewsWebView()
                webView?.setParams()
                webView?.newsDelegate = self
                webView?.frame = CGRect(x: 0, y: 0, width: CYDevice.width(), height: webViewHeight)
                headerView?.contentView.addSubview(webView!)
            }
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return webViewHeight
        }
        return 0.001
    }
    
    /// 请求新闻详情数据
    func asynchronousGet() {
        
        // https://c.m.163.com/nc/article/DBG95HS10001875O/full.html
        let id: String = (self.params?.id)!
        let urlStr: String = "https://c.m.163.com/nc/article/\(id)/full.html"
        
        // 1、创建URL对象；
        let url:URL! = URL(string: urlStr);
        
        // 2、创建Request对象
        // url: 请求路径
        // cachePolicy: 缓存协议
        // timeoutInterval: 网络请求超时时间(单位：秒)
        let urlRequest:URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        // 3、连接服务器
        let connection:NSURLConnection? = NSURLConnection(request: urlRequest, delegate: self)
        connection?.schedule(in: .current, forMode: .defaultRunLoopMode)
        connection?.start()
    }
    
    func loadHTML() {
        let body: String = dataSoucre!["body"] as! String
        self.loadHTMLBody(body: body, img: dataSoucre!["img"] as! Array)
    }
    
    /// 拼HTML字符串
    /*
     alt = "";
     pixel = "589*381";
     ref = "<!--IMG#0-->";
     src = "http://spider.nosdn.127.net/d1956118c5d2f99a83215a101e20a8a4.jpeg";
     */
    func loadHTMLBody(body: String, img: Array<Dictionary<String, String>>) {
        
        var i = 0
        
        var newBody: String = body
        
        for imageInfo in img {
            let pixel: Array = (imageInfo["pixel"]?.components(separatedBy: "*"))!
            if pixel.count != 2 {
                continue
            }
            var width: String = pixel[0]
            var height: String = pixel[0]
            
            let tempH:CGFloat = CGFloat(Double(height)!) / CGFloat(Double(width)!) * CYDevice.width() * 0.92 - 0.5
            
            height = String.init(format: "%f", tempH)
            width = String.init(format: "%f", CYDevice.width() * 0.92)
            
            let canvas: String = String.init(format: "<div class=\"a%d\" id=\"guobinImageID%d\" style=\"width:%@px;height:%@px;background:#F4F4F4; text-align:center;line-height:%@px\"></div>", i,i,width,height,height)
            newBody = newBody.replacingOccurrences(of: imageInfo["ref"]!, with: canvas)
            
//            [_imageUrls addObject:[imageInfo valueForKey:@"src"]];
            i += 1;
        }
        print(newBody)
        
        let engine: MGTemplateEngine = MGTemplateEngine()
        engine.matcher = ICUTemplateMatcher(templateEngine: engine)
        engine.setObject(newBody, forKey: "content")
        
        let templatePath: String = Bundle.main.path(forResource: "HTMLTemplate", ofType: "html")!
        let html: String = engine.processTemplate(templatePath, withVariables: nil)
        
        webView?.loadHTMLString(html, baseURL: nil)
    }

    // MARK: - NewsWebDelegate
    func updateWebCellHegiht(webView: NewsWebView) {
        
        webViewHeight = webView.height
        
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    func webLoadFinishUpdateOthersData(webView: NewsWebView) {
        
    }
    
    func clickPhoto(webView: NewsWebView, urls: Array<String>, selIndex: NSInteger) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let y: CGFloat = CYDevice.statusBar_h()
        self.tableView.frame = CGRect.init(x: 0, y: y, width: self.view.width, height: self.view.height - y - bottomBarH)
        
    }

    deinit {
        print("\(self) -> 释放了")
    }
    
    

}

// MARK - NSURLConnectionDataDelegate
extension NewsDetailsViewController:NSURLConnectionDataDelegate {
    
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        
        //接收响应
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
//        print("data count ---> \(data.count)")
        //收到数据
        self.jsonData.append(data);
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        //请求结束
        do {
            let dic = try JSONSerialization.jsonObject(with: self.jsonData as Data, options: JSONSerialization.ReadingOptions.allowFragments)
//            print(dic)
            let dataDic: Dictionary = dic as! Dictionary<String, Dictionary<String, Any>>
            self.dataSoucre = dataDic[(self.params?.id)!]
            
        } catch let error{
            print(error.localizedDescription);
        }
    }
}
