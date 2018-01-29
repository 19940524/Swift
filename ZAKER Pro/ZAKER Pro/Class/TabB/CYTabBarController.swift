//
//  CYTabBarController.swift
//  CYViewController
//
//  Created by 红鹊豆 on 2018/1/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class CYTabBarController: UITabBarController {
    
    let imgBundle = Bundle(path: Bundle.main.path(forResource: "theme_default", ofType: "bundle")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = NAV_COLOR
        self.creatSubViewController()
    }
    
    func creatSubViewController() {
        
        let homeVC = CYHomeViewController()
        homeVC.title = "资讯"
        let hNavVC = CYNavigationController(rootViewController:homeVC)
        hNavVC.tabBarItem.title = "资讯"
        hNavVC.tabBarItem.selectedImage = UIImage(named:"DashboardTabBarItemInformation")
        hNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemInformation")?.withRenderingMode(.alwaysOriginal)
        
        let videoVC = CYVideoViewController()
        videoVC.title = "视频"
        let vNavVC = CYNavigationController(rootViewController:videoVC)
        vNavVC.tabBarItem.title = "视频"
        vNavVC.tabBarItem.selectedImage = UIImage(named:"DashboardTabBarItemShortVideo")
        vNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemShortVideo")?.withRenderingMode(.alwaysOriginal)
        
        let localVC = CYLocalViewController()
        localVC.title = "本地"
        let lNavVC = CYNavigationController(rootViewController:localVC)
        lNavVC.tabBarItem.title = "本地"
        lNavVC.tabBarItem.selectedImage = UIImage(named:"DashboardTabBarItemLocal")
        lNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemLocal")?.withRenderingMode(.alwaysOriginal)
        
        let socialVC = CYSocialViewController()
        socialVC.title = "社区"
        let sNavVC = CYNavigationController(rootViewController:socialVC)
        sNavVC.tabBarItem.title = "社区"
        sNavVC.tabBarItem.selectedImage = UIImage(named:"DashboardTabBarItemDiscussion")
        sNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemDiscussion")?.withRenderingMode(.alwaysOriginal)
        
        let meVC = CYMeViewController()
        meVC.title = "我的"
        let mNavVC = CYNavigationController(rootViewController:meVC)
        mNavVC.tabBarItem.title = "我的"
        mNavVC.tabBarItem.selectedImage = UIImage(named:"DashboardTabBarItemProfile")
        mNavVC.tabBarItem.image = UIImage(named:"DashboardTabBarItemProfile")?.withRenderingMode(.alwaysOriginal)
        
        let viewControllers = [hNavVC,vNavVC,lNavVC,sNavVC,mNavVC]
        
        self.viewControllers = viewControllers
        
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9, weight: .ultraLight),
                          NSAttributedStringKey.foregroundColor: UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
        for nc in viewControllers {
            nc.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
            nc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: NAV_COLOR], for: .selected)
            nc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    func getSelImage(name: String) -> UIImage {
        let selImg = UIImage(named:name)
        return selImg!
    }
    
    func getNormalImg(name: String) -> UIImage {
        return (UIImage(named:name)?.withRenderingMode(.alwaysOriginal))!
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
