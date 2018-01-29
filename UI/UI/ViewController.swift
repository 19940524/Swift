//
//  ViewController.swift
//  UI
//
//  Created by 红鹊豆 on 2018/1/29.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let headerNames = ["Views and Controls",
                       "Container Views",
                       "Content Views",
                       "Controls"]
    
    let viewsAndControls = ["Views and Controls" : ["UIView"]]
    let containerViews   = ["Container Views"    : ["Table Views",
                                                    "Collection Views",
                                                    "UIScrollView",
                                                    "UIStackView"]];
    
    let contentViews    = ["Content Views"       : ["UIImageView",
                                                    "UIPickerView",
                                                    "UIProgressView",
                                                    "UIActivityIndicatorView",
                                                    "UIWebView"]]
    
    let control         = ["Controls"            : ["UIButton",
                                                    "UISwitch",
                                                    "UISlider",
                                                    "UIDatePicker",
                                                    "UIPageControl",
                                                    "UISegmentedControl",
                                                    "UIStepper"]]
    
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView = UITableView(frame: CGRect(), style: .plain)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.rowHeight = 44
        
//        tableView = UITableView(frame: self.view.bounds, style: .plain)
//        tableView?.dataSource = self
//        tableView?.rowHeight = 44
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}













