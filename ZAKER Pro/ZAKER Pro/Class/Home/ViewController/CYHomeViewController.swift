//
//  CYHomeViewController.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/1/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class CYHomeViewController: CYViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createNavigationBar()
        
        
        
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("测试", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.center = self.view.center
        button.addTarget(self, action: #selector(CYHomeViewController.buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
    }

    @objc func buttonAction() {
        for view in (self.navigationController?.navigationBar.subviews)! {
            print("----------------",view)
            for subview in view.subviews {
                print(subview)
            }
        }
    }
    
    
    
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
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
