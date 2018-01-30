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
    
    let allValue = ["Views and Controls" : ["UIView"],
                   "Container Views"    : ["Table Views",
                                           "Collection Views",
                                           "UIScrollView",
                                           "UIStackView"],
                   "Content Views"       : ["UIImageView",
                                            "UIPickerView",
                                            "UIProgressView",
                                            "UIActivityIndicatorView",
                                            "UIWebView"],
                   "Controls"            : ["UIButton",
                                            "UISwitch",
                                            "UISlider",
                                            "UIDatePicker",
                                            "UIPageControl",
                                            "UISegmentedControl",
                                            "UIStepper"]]
    
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.view.bounds, style: .plain);
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 44
        self.tableView.sectionHeaderHeight = 40
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        self.view.addSubview(self.tableView!)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerNames.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let name = headerNames[section]
        
        let values = allValue[name]
        
        return values!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let name = headerNames[indexPath.section]
        let values = allValue[name]
        
        cell.textLabel?.text = values![indexPath.row]
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView")
        headerView?.textLabel?.text = headerNames[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(CYDevice.isPortrait());
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setTableFrame()
        
    }
    
    func setTableFrame() {
        
        let y = CYDevice.isPortrait() ? 20 : 0
        let height = CYDevice.isPortrait() ? CYDevice.height()-y : CYDevice.height()
        tableView.frame = CGRect(x: 0, y: y, width: CYDevice.width(), height: height)
    }
    
    @objc func orientationDidChange() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
        }
        self.setTableFrame()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}













