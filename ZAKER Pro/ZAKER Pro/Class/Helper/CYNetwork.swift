//
//  CYNetwork.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/26.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Foundation
import SwiftyJSON
import Cache
import ImageIO
import MobileCoreServices

class CYNetwork {
    // 初始化单例
    static let shared = CYNetwork()
    private init() {}
    
    internal let loadMax: Int = 6
//    internal var 
    
    
    
}

extension UIImageView {
    
    public func bb_setImage(
        withURL url: URL,
        placeholderImage: UIImage? = nil,
        filter: ImageFilter? = nil,
        progress: ImageDownloader.ProgressHandler? = nil,
        progressQueue: DispatchQueue = DispatchQueue.main,
        imageTransition: ImageTransition = .noTransition,
        runImageTransitionIfCached: Bool = false,
        completion: ((DataResponse<UIImage>) -> Void)? = nil) {
        // 判断url是否在data cache中
        let diskConfig = DiskConfig(name: "Floppy")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
        let storage = try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        
        let tempData = try? storage?.object(ofType: Data.self, forKey: url.absoluteString)
        self.stopAnimatingGIF()
        
        if tempData != nil  {
            self.image = nil
            let data: Data = tempData!!
            self.animate(withGIFData: data)
            
        } else {
            
            self.af_setImage(withURL: url,
                             placeholderImage: placeholderImage,
                             filter: filter,
                             progress: progress,
                             progressQueue: progressQueue,
                             imageTransition: imageTransition,
                             runImageTransitionIfCached: runImageTransitionIfCached,
                             completion: { (response) in
                                if response.result.isSuccess && (response.data != nil) {
                                    let imageData: NSData = response.data! as NSData
                                    if imageData.bb_imageFormat == .GIF {
                                        try? storage?.setObject(response.data, forKey: url.absoluteString)
                                        self.animate(withGIFData: response.data!)
                                    }
                                }
                                
            })
        }
        
        
    }
}


