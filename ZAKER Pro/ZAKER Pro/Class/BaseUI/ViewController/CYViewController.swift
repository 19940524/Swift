//
//  CYViewController.swift
//  CYViewController
//
//  Created by 红鹊豆 on 2018/1/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class CYViewController: UIViewController {

    override var title: String? {
        get {
            return super.title
        }
        set {
            super.title = newValue
            self.bbNavigationBar?.setText(title: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width = CYDevice.width()
        let height = CYDevice.navigation_h()
        self.bbNavigationBar?.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
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
