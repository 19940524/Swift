//
//  UIImageView+AlamofireImage.swift
//
//  Copyright (c) 2015-2017 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Alamofire
import Foundation

#if os(iOS) || os(tvOS)

import UIKit

/// UIImageView 图片请求 扩展类
extension UIImageView {

    // MARK: - ImageTransition

    /// Used to wrap all `UIView` animation transition options alongside a duration.
    /// 用于将所有的“UIView”动画持续时间与过渡动画选项。
    public enum ImageTransition {
        case noTransition
        case crossDissolve(TimeInterval)
        case curlDown(TimeInterval)
        case curlUp(TimeInterval)
        case flipFromBottom(TimeInterval)
        case flipFromLeft(TimeInterval)
        case flipFromRight(TimeInterval)
        case flipFromTop(TimeInterval)
        case custom(
            duration: TimeInterval,
            animationOptions: UIViewAnimationOptions,
            animations: (UIImageView, Image) -> Void,
            completion: ((Bool) -> Void)?
        )

        /// The duration of the image transition in seconds.
        /// 图像转换的持续时间以秒为单位。
        public var duration: TimeInterval {
            switch self {
            case .noTransition:
                return 0.0
            case .crossDissolve(let duration):  // 淡入淡出
                return duration
            case .curlDown(let duration):       // 卷下来
                return duration
            case .curlUp(let duration):         // 卷上去
                return duration
            case .flipFromBottom(let duration): // 从底部翻转
                return duration
            case .flipFromLeft(let duration):   // 从左翻转
                return duration
            case .flipFromRight(let duration):  // 从右翻转
                return duration
            case .flipFromTop(let duration):    // 从上翻转
                return duration
            case .custom(let duration, _, _, _):// 自定义
                return duration
            }
        }

        /// The animation options of the image transition.
        /// 图像过渡的动画选项。
        public var animationOptions: UIViewAnimationOptions {
            switch self {
            case .noTransition:
                return UIViewAnimationOptions()
            case .crossDissolve:
                return .transitionCrossDissolve     // 淡入淡出
            case .curlDown:
                return .transitionCurlDown          // 卷下来
            case .curlUp:
                return .transitionCurlUp            // 卷上去
            case .flipFromBottom:
                return .transitionFlipFromBottom    // 从底部翻转
            case .flipFromLeft:
                return .transitionFlipFromLeft      // 从左翻转
            case .flipFromRight:
                return .transitionFlipFromRight     // 从右翻转
            case .flipFromTop:
                return .transitionFlipFromTop       // 从上翻转
            case .custom(_, let animationOptions, _, _): // 自定义
                return animationOptions
            }
        }

        /// The animation options of the image transition.
        public var animations: ((UIImageView, Image) -> Void) {
            switch self {
            case .custom(_, _, let animations, _):
                return animations
            default:
                return { $0.image = $1 }
            }
        }

        /// The completion closure associated with the image transition.
        public var completion: ((Bool) -> Void)? {
            switch self {
            case .custom(_, _, _, let completion):
                return completion
            default:
                return nil
            }
        }
    }

    // MARK: - Private - AssociatedKeys 动态绑定相关key

    private struct AssociatedKey {
        static var imageDownloader = "af_UIImageView.ImageDownloader"               // 图片下载器
        static var sharedImageDownloader = "af_UIImageView.SharedImageDownloader"   // 共享图片下载器
        static var activeRequestReceipt = "af_UIImageView.ActiveRequestReceipt"     // 有效的请求收据
    }

    // MARK: - Associated Properties    相关属性

    /// The instance image downloader used to download all images. If this property is `nil`, the `UIImageView` will
    /// fallback on the `af_sharedImageDownloader` for all downloads. The most common use case for needing to use a
    /// custom instance image downloader is when images are behind different basic auth credentials.
    /// 实例图像下载器用于下载所有图像。果该属性为“nil”，那么“UIImageView”将会在“af_sharedImageDownloader”中返回所有下载。
    /// 需要使用自定义实例图像下载器的最常见的用例是当映像在不同的基本auth凭证后面。
    public var af_imageDownloader: ImageDownloader? {
        get {
            // 获取关联对象
            return objc_getAssociatedObject(self, &AssociatedKey.imageDownloader) as? ImageDownloader
        }
        set(downloader) {
            // 设置关联对象
            objc_setAssociatedObject(self, &AssociatedKey.imageDownloader, downloader, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// The shared image downloader used to download all images. By default, this is the default `ImageDownloader`
    /// instance backed with an `AutoPurgingImageCache` which automatically evicts images from the cache when the memory
    /// capacity is reached or memory warning notifications occur. The shared image downloader is only used if the
    /// `af_imageDownloader` is `nil`.
    /// 用于下载所有图像的共享图像下载器。这是默认的“ImageDownloader”实例，它有一个“AutoPurgingImageCache”，
    /// 当内存容量达到或发出内存警告时，它自动将图像从缓存中清除。
    /// 只有“af_imageDownloader”是“nil”时才使用共享图像下载器。
    public class var af_sharedImageDownloader: ImageDownloader {
        get {
            // 获取关联对象
            if let downloader = objc_getAssociatedObject(self, &AssociatedKey.sharedImageDownloader) as? ImageDownloader {
                return downloader
            } else {
                // 获取默认实例
                return ImageDownloader.default
            }
        }
        set {
            // 设置关联对象
            objc_setAssociatedObject(self, &AssociatedKey.sharedImageDownloader, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var af_activeRequestReceipt: RequestReceipt? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.activeRequestReceipt) as? RequestReceipt
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.activeRequestReceipt, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: - Image Download 图片下载

    /// Asynchronously downloads an image from the specified URL, applies the specified image filter to the downloaded
    /// image and sets it once finished while executing the image transition.
    ///
    /// If the image is cached locally, the image is set immediately. Otherwise the specified placeholder image will be
    /// set immediately, and then the remote image will be set once the image request is finished.
    ///
    /// The `completion` closure is called after the image download and filtering are complete, but before the start of
    /// the image transition. Please note it is no longer the responsibility of the `completion` closure to set the
    /// image. It will be set automatically. If you require a second notification after the image transition completes,
    /// use a `.Custom` image transition with a `completion` closure. The `.Custom` `completion` closure is called when
    /// the image transition is finished.
    /// 指定URL并异步下载图像，将指定的图像过滤器应用到下载的图像，并在执行图像转换时设置完成。如果图像在本地缓存，则立即设置图像。否则，将立即设置指定的占位符映像，然后在完成图像请求后将设置远程映像。“完成”闭包是在图像下载和过滤完成之后调用的，但是在图像转换开始之前。请注意，它不再是“完成”闭包的责任来设置图像。它将被自动设置。如果在图像转换完成后需要第二个通知，请使用“。”自定义'图像转换与'完成'关闭。”。当图像转换完成时，将调用自定义的“完成”闭包。
    ///
    /// - parameter url:                        The URL used for the image request.
    /// 用于图像请求的URL。
    /// - parameter placeholderImage:           The image to be set initially until the image request finished. If
    ///                                         `nil`, the image view will not change its image until the image
    ///                                         request finishes. Defaults to `nil`.
    /// 首先设置图像，直到图像请求完成。如果“nil”，图像视图在图像请求结束之前不会改变其图像。默认为“nil”。
    /// - parameter filter:                     The image filter applied to the image after the image request is
    ///                                         finished. Defaults to `nil`.
    /// 在图像请求完成后，图像过滤器应用于图像。默认为“nil”。
    /// - parameter progress:                   The closure to be executed periodically during the lifecycle of the
    ///                                         request. Defaults to `nil`.
    /// 在请求的生命周期中周期性地执行闭包。默认为“nil”。(每下载到一段数据就调用一次)
    /// - parameter progressQueue:              The dispatch queue to call the progress closure on. Defaults to the
    ///                                         main queue.
    /// 每下载到一段数据就调用一次,设置调用时候的线程 默认是主线程
    /// - parameter imageTransition:            The image transition animation applied to the image when set.
    ///                                         Defaults to `.None`.
    /// 图片加载完成时的过渡动画  默认无动画
    /// - parameter runImageTransitionIfCached: Whether to run the image transition if the image is cached. Defaults
    ///                                         to `false`.
    /// - parameter completion:                 A closure to be executed when the image request finishes. The closure
    ///                                         has no return value and takes three arguments: the original request,
    ///                                         the response from the server and the result containing either the
    ///                                         image or the error that occurred. If the image was returned from the
    ///                                         image cache, the response will be `nil`. Defaults to `nil`.
    /// 当图像请求结束时要执行的闭包。闭包没有返回值，并接受三个参数:原始请求、服务器响应和包含图像的结果或发生的错误。如果图像从图像缓存返回，响应将为“nil”。默认为“nil”。
    public func af_setImage(
        withURL url: URL,
        placeholderImage: UIImage? = nil,
        filter: ImageFilter? = nil,
        progress: ImageDownloader.ProgressHandler? = nil,
        progressQueue: DispatchQueue = DispatchQueue.main,
        imageTransition: ImageTransition = .noTransition,
        runImageTransitionIfCached: Bool = false,
        completion: ((DataResponse<UIImage>) -> Void)? = nil)
    {
        af_setImage(
            withURLRequest: urlRequest(with: url),
            placeholderImage: placeholderImage,
            filter: filter,
            progress: progress,
            progressQueue: progressQueue,
            imageTransition: imageTransition,
            runImageTransitionIfCached: runImageTransitionIfCached,
            completion: completion
        )
    }

    /// Asynchronously downloads an image from the specified URL Request, applies the specified image filter to the downloaded
    /// image and sets it once finished while executing the image transition.
    ///
    /// If the image is cached locally, the image is set immediately. Otherwise the specified placeholder image will be
    /// set immediately, and then the remote image will be set once the image request is finished.
    ///
    /// The `completion` closure is called after the image download and filtering are complete, but before the start of
    /// the image transition. Please note it is no longer the responsibility of the `completion` closure to set the
    /// image. It will be set automatically. If you require a second notification after the image transition completes,
    /// use a `.Custom` image transition with a `completion` closure. The `.Custom` `completion` closure is called when
    /// the image transition is finished.
    ///
    /// - parameter urlRequest:                 The URL request.
    /// - parameter placeholderImage:           The image to be set initially until the image request finished. If
    ///                                         `nil`, the image view will not change its image until the image
    ///                                         request finishes. Defaults to `nil`.
    /// - parameter filter:                     The image filter applied to the image after the image request is
    ///                                         finished. Defaults to `nil`.
    /// - parameter progress:                   The closure to be executed periodically during the lifecycle of the
    ///                                         request. Defaults to `nil`.
    /// - parameter progressQueue:              The dispatch queue to call the progress closure on. Defaults to the
    ///                                         main queue.
    /// - parameter imageTransition:            The image transition animation applied to the image when set.
    ///                                         Defaults to `.None`.
    /// - parameter runImageTransitionIfCached: Whether to run the image transition if the image is cached. Defaults
    ///                                         to `false`.
    /// - parameter completion:                 A closure to be executed when the image request finishes. The closure
    ///                                         has no return value and takes three arguments: the original request,
    ///                                         the response from the server and the result containing either the
    ///                                         image or the error that occurred. If the image was returned from the
    ///                                         image cache, the response will be `nil`. Defaults to `nil`.
    public func af_setImage(
        withURLRequest urlRequest: URLRequestConvertible,
        placeholderImage: UIImage? = nil,
        filter: ImageFilter? = nil,
        progress: ImageDownloader.ProgressHandler? = nil,
        progressQueue: DispatchQueue = DispatchQueue.main,
        imageTransition: ImageTransition = .noTransition,
        runImageTransitionIfCached: Bool = false,
        completion: ((DataResponse<UIImage>) -> Void)? = nil)
    {
        // 判断当前URL不是 ImageView 正在请求的URL. 如果是!执行里面代码
        guard !isURLRequestURLEqualToActiveRequestURL(urlRequest) else {
            let error = AFIError.requestCancelled  // 取消请求
            let response = DataResponse<UIImage>(request: nil, response: nil, data: nil, result: .failure(error))

            completion?(response)

            return
        }
        // 取消 Image 下载
        af_cancelImageRequest()

        // 获取图片下载器与图片缓存器
        let imageDownloader = af_imageDownloader ?? UIImageView.af_sharedImageDownloader
        let imageCache = imageDownloader.imageCache

        // Use the image from the image cache if it exists
        // 如果图片存在缓存,就使用它 ...
        if
            let request = urlRequest.urlRequest,
            let image = imageCache?.image(for: request, withIdentifier: filter?.identifier)
        {
            let response = DataResponse<UIImage>(request: request, response: nil, data: nil, result: .success(image))

            if runImageTransitionIfCached {
                let tinyDelay = DispatchTime.now() + Double(Int64(0.001 * Float(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

                // Need to let the runloop cycle for the placeholder image to take affect
                DispatchQueue.main.asyncAfter(deadline: tinyDelay) {
                    self.run(imageTransition, with: image)
                    completion?(response)
                }
            } else {
                self.image = image
                completion?(response)
            }

            return
        }

        // Set the placeholder since we're going to have to download
        // 设置占位图片
        if let placeholderImage = placeholderImage { self.image = placeholderImage }

        // Generate a unique download id to check whether the active request has changed while downloading
        // 生成唯一的下载id，以检查活动请求是否在下载时发生了更改。
        let downloadID = UUID().uuidString

        // Download the image, then run the image transition or completion handler
        // 下载图像，然后运行图像转换或完成处理程序。
        // 断点
        let requestReceipt = imageDownloader.download(
            urlRequest,
            receiptID: downloadID,
            filter: filter,
            progress: progress,
            progressQueue: progressQueue,
            completion: { [weak self] response in
                guard
                    let strongSelf = self,
                    strongSelf.isURLRequestURLEqualToActiveRequestURL(response.request) &&
                    strongSelf.af_activeRequestReceipt?.receiptID == downloadID
                else {
                    completion?(response)
                    return
                }

                if let image = response.result.value {
                    strongSelf.run(imageTransition, with: image)
                }

                strongSelf.af_activeRequestReceipt = nil

                completion?(response)
            }
        )

        af_activeRequestReceipt = requestReceipt
    }

    // MARK: - Image Download Cancellation  // 取消下载图片

    /// Cancels the active download request, if one exists.
    /// 如果图片正在请求的话,取消下载
    public func af_cancelImageRequest() {
        // 不存在有效的请求收据就结束代码块
        guard let activeRequestReceipt = af_activeRequestReceipt else { return }
        
        // 取消下载器中当前请求
        let imageDownloader = af_imageDownloader ?? UIImageView.af_sharedImageDownloader
        imageDownloader.cancelRequest(with: activeRequestReceipt)
        
        // 收回请求收据
        af_activeRequestReceipt = nil
    }

    // MARK: - Image Transition

    /// Runs the image transition on the image view with the specified image.
    ///
    /// - parameter imageTransition: The image transition to ran on the image view.
    /// - parameter image:           The image to use for the image transition.
    public func run(_ imageTransition: ImageTransition, with image: Image) {
        UIView.transition(
            with: self,
            duration: imageTransition.duration,
            options: imageTransition.animationOptions,
            animations: { imageTransition.animations(self, image) },
            completion: imageTransition.completion
        )
    }

    // MARK: - Private - URL Request Helper Methods URL请求辅助方法

    private func urlRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)

        for mimeType in DataRequest.acceptableImageContentTypes {
            urlRequest.addValue(mimeType, forHTTPHeaderField: "Accept")
        }

        return urlRequest
    }

    /// 判断当前URL是不是 ImageView 正在请求的URL
    private func isURLRequestURLEqualToActiveRequestURL(_ urlRequest: URLRequestConvertible?) -> Bool {
        if
            let currentRequestURL = af_activeRequestReceipt?.request.task?.originalRequest?.url,
            let requestURL = urlRequest?.urlRequest?.url,
            currentRequestURL == requestURL
        {
            return true
        }

        return false
    }
}

#endif
