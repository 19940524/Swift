//
//  CustomNavigationBar.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit


let nbTag = 1600
let leTag = 1601

extension UIViewController {

    var bbNavigationBar: BBNavigationBar? {

        var view: BBNavigationBar? = nil
        // 是否创建了导航栏  有就返回  无为nil
        if self.view.viewWithTag(nbTag) != nil {
            view = (self.view.viewWithTag(nbTag) as! BBNavigationBar)
            if self.title != nil {
                view?.titleLabel.text = self.title
            }
        }
        return view
    }
    
    // @discardableResult  修饰符 未引用不会报错
    /// 创建导航栏
    ///
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar() -> BBNavigationBar {
        let navigationBar = BBNavigationBar()
        navigationBar.tag = nbTag
        self.view.addSubview(navigationBar)
        
        
        return navigationBar
    }
    
    /// 创建带标题导航栏
    ///
    /// - Parameter title: 标题
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar(title: String?) -> BBNavigationBar {
        return createNavigationBar(title: title, leftSel: nil)
    }
    
    /// 有返回事件的导航栏 无标题 默认黑色返回图标
    ///
    /// - Parameter leftSel: 按钮事件
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar(leftSel:Selector?) -> BBNavigationBar {
        return createNavigationBar(title: nil,left: true,leftSel: leftSel,whiteIcon: false)
    }
    
    /// 有返回事件带标题的导航栏 默认黑色返回图标
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - leftSel: 按钮事件
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar(title: String?, leftSel:Selector?) -> BBNavigationBar {
        return createNavigationBar(title: title, left: true,leftSel: leftSel,whiteIcon: false)
    }
    
    /// 有返回事件带标题的导航栏 可选返回图标颜色(黑与白)
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - leftSel: 按钮事件
    ///   - whiteIcon: 是否白色返回图标
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar(title: String?, left: Bool, leftSel:Selector?,whiteIcon: Bool) -> BBNavigationBar {
        return createNavigationBar(title: title,left: left, leftSel: leftSel,name: nil, rightSel: nil, whiteIcon: whiteIcon)
    }
    
    /// 不带标题 有右边按钮事件的导航栏
    ///
    /// - Parameters:
    ///   - name: 图片名称
    ///   - rightSel: 按钮事件
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar(name: String?, rightSel: Selector?) -> BBNavigationBar {
        return createNavigationBar(title: nil, name: name, rightSel: rightSel)
    }
    
    /// 带标题 有右边按钮事件的导航栏
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - name: 图片名称
    ///   - rightSel: 按钮事件
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar(title: String?, name: String?, rightSel: Selector?) -> BBNavigationBar {
        return createNavigationBar(title: title,left: false, leftSel: nil, name: name, rightSel: rightSel, whiteIcon: false)
    }
    
    /// 基础创建方法
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - leftSel: 左按钮事件
    ///   - name: 右图片名称
    ///   - rightSel:  右按钮事件
    ///   - whiteIcon: 是否白色返回图标 否则黑色
    /// - Returns: 导航栏视图
    @discardableResult func createNavigationBar(title   : String?,
                                                left    : Bool,
                                                leftSel : Selector?,
                                                name    : String?,
                                                rightSel: Selector?,
                                                whiteIcon: Bool) -> BBNavigationBar {
        let navigationBar = createNavigationBar()
        navigationBar.titleLabel.text = title
        if left {
            let image = UIImage(named: whiteIcon ? "addRootBlock_toolbar_white_return" : "addRootBlock_toolbar_return")
            navigationBar.leftItem.setImage(image, for: .normal)
            if leftSel != nil {
                navigationBar.leftItem.addTarget(self, action: leftSel!, for: .touchUpInside)
            }
        }
        
        if name != nil {
            navigationBar.rightItem.setImage(UIImage(named: name!), for: .normal)
            if rightSel != nil {
                navigationBar.rightItem.addTarget(self, action: rightSel!, for: .touchUpInside)
            }
        }
        return navigationBar
    }
    
    
    
    
}
