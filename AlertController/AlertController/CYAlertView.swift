//
//  UIAlertController+Convenient.swift
//  AlertController
//
//  Created by 红鹊豆 on 2018/4/4.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

typealias CompletionBlock = (Int) -> ()
typealias DestructiveBlock = () -> ()

class CYAlertView {
    
    static func show(
        title           : String? = nil,
        message         : String? = nil,
        destructive     : String? = nil,
        cancel          : String? = nil,
        preferredStyle  : UIAlertControllerStyle = .alert,
        otherTitles     : Array<String> = [String](),
        destructiveBlock: DestructiveBlock? = nil,
        completion      : CompletionBlock? = nil) {
        
        
        assert(destructive != nil || cancel != nil || otherTitles.count != 0, "CYAlertView 至少要有一个选择按钮")
        
        let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if destructive != nil {
            let desAction : UIAlertAction = UIAlertAction(title: destructive, style: .destructive, handler: { (action) in
                if destructiveBlock != nil {
                    destructiveBlock!()
                }
            })
            alert.addAction(desAction)
        }
        var newOtherTitle = otherTitles
        
        if cancel != nil {
            newOtherTitle.insert(cancel!, at: 0)
        }
        
        var index: Int = 0
        for itemTitle in newOtherTitle {
            if index == 0 {
                let cancelAction : UIAlertAction = UIAlertAction(title: itemTitle, style: .cancel, handler: { (action) in
                    if completion != nil {
                        completion!(newOtherTitle.index(of: itemTitle)!)
                    }
                })
                alert.addAction(cancelAction)
            } else {
                let alertAction : UIAlertAction = UIAlertAction(title: itemTitle, style: .default, handler: { (action) in
                    if completion != nil {
                        completion!(newOtherTitle.index(of: itemTitle)!)
                    }
                })
                alert.addAction(alertAction)
            }
            index += 1
        }
        
        UIViewController.currentViewController()?.present(alert, animated: true, completion: nil)
    }
}


extension UIViewController {
    static func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
