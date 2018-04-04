//
//  ViewController.swift
//  AlertController
//
//  Created by 红鹊豆 on 2018/4/4.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    @IBAction func show(_ sender: Any) {
        CYAlertView.show(title  : "薛国宾喜欢美女",
                         message: "嘿嘿",
                         cancel : "是的")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

