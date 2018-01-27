//
//  CYTabBarController.swift
//  CYViewController
//
//  Created by 红鹊豆 on 2018/1/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class CYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = NAV_COLOR
        self.creatSubViewController()
    }

    func creatSubViewController() {
        
        let bundlePath = Bundle.main.path(forResource: "theme_default", ofType: "bundle")
        let bundle = Bundle()
//        let imgPath = imgBundle.path
        
        
        
        let homeVC = CYHomeViewController()
        homeVC.title = "资讯"
        let hNavVC = CYNavigationController(rootViewController:homeVC)
        hNavVC.tabBarItem.title = "资讯"
        
//        hNavVC.tabBarItem.image = UIImage(named name:"DashboardTabBarItemInformation",:"theme_default",:nil)
//        named name: "DashboardTabBarItemInformation", bundle: Bundle, compatibleWith traitCollection: UITraitCollection?
        let videoVC = CYVideoViewController()
        videoVC.title = "视频"
        let vNavVC = CYNavigationController(rootViewController:videoVC)
        vNavVC.tabBarItem.title = "视频"
        vNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemShortVideo")
        
        
        let localVC = CYLocalViewController()
        localVC.title = "本地"
        let lNavVC = CYNavigationController(rootViewController:localVC)
        lNavVC.tabBarItem.title = "本地"
        lNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemLocal")
        
        let socialVC = CYSocialViewController()
        socialVC.title = "社区"
        let sNavVC = CYNavigationController(rootViewController:socialVC)
        sNavVC.tabBarItem.title = "社区"
        sNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemDiscussion")
        
        let meVC = CYMeViewController()
        meVC.title = "我的"
        let mNavVC = CYNavigationController(rootViewController:meVC)
        mNavVC.tabBarItem.title = "我的"
        mNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemProfile")
        
        let viewControllers = [hNavVC,vNavVC,lNavVC,sNavVC,mNavVC]
        
        self.viewControllers = viewControllers
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
