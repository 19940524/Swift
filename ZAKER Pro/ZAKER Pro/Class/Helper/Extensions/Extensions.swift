//
//  Extensions.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/1/28.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

let nbTag = 1600

extension UIViewController {
    
    
    var bbNavigationBar: BBNavigationBar? {
        let view: BBNavigationBar = self.view.viewWithTag(nbTag) as! BBNavigationBar
        return view
    }
    
    
    @discardableResult
    func createNavigationBar() -> BBNavigationBar {
        
        let navigationBar = BBNavigationBar()
        
        self.view.addSubview(navigationBar)
        
        return navigationBar
    }
    
}
