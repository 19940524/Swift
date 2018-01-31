//
//  DestinationViewController.swift
//  UI
//
//  Created by 红鹊豆 on 2018/1/31.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class DestinationViewController: UIViewController {

    var uiName : String?
    var myView: MyView!
    var myTableView: MyTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.title = uiName
        
        if uiName == "UIView" {
            let min = CGFloat.minimum(CYDevice.width(), CYDevice.height())
            
            myView = MyView()
            myView.frame = CGRect(x: 0.0, y: CGFloat(CYDevice.navHeight()), width: min, height: min)
            self.view.addSubview(myView)
            
        } else if uiName == "Table Views" {
            let segmented   = UISegmentedControl(items: ["删除","插入"])
            segmented.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
            segmented.selectedSegmentIndex = 0
            segmented.addTarget(self, action: #selector(DestinationViewController.segmentedAction(control:)), for: UIControlEvents.valueChanged)
            let rightItem   = UIBarButtonItem(customView: segmented)
            self.navigationItem.rightBarButtonItem = rightItem
            
            myTableView = MyTableView(frame: CGRect(), style: UITableViewStyle.plain)
            
            self.view.addSubview(myTableView)
            
        }
        
        
    }
    
     override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if myView != nil {
            var min = CGFloat.minimum(CYDevice.width(), CYDevice.height())
            min -= 100.0
            myView.frame = CGRect(x: CYDevice.width()/2-min/2, y: CYDevice.height()/2-min/2, width: min, height: min)
        }
        if myTableView != nil {
            myTableView.frame = CGRect(x: 0.0, y: CYDevice.navHeight(),
                                       width: CYDevice.width(),
                                       height: CYDevice.height()-CYDevice.navHeight())
        }
    }
    
    /// table view 编辑样式
    ///
    /// - Parameter control: UISegmentedControl控件
    @objc func segmentedAction(control: UISegmentedControl) {
        let index = control.selectedSegmentIndex
        if index == 0 {
            myTableView.editingStyle = .delete
        } else {
            myTableView.editingStyle = .insert
        }
        myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
