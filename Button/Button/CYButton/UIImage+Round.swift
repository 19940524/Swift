//
//  UIImage+Round.swift
//  Button
//
//  Created by 红鹊豆 on 2018/4/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import ImageIO

extension UIImage {
    
    
    public func roundCornerRadius(
        radius : CGFloat,
        borderWidth : CGFloat = 0,
        borderColor : UIColor? = nil) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect : CGRect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -rect.size.height)
        
        let minSize = min(self.size.width, self.size.height)
        if borderWidth < minSize / 2 {
            let path : UIBezierPath = UIBezierPath.init(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: radius, height: borderWidth))
            path.close()
            
            context?.saveGState()
            path.addClip()
            context?.draw(self.cgImage!, in: rect)
            context?.restoreGState()
            
            path.lineWidth = borderWidth
            borderColor?.setStroke()
            path.stroke()
        }
        
        if borderColor != nil && borderWidth < minSize / 2 && borderWidth > 0 {
            let strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0
            let path : UIBezierPath = UIBezierPath.init(roundedRect: strokeRect, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: strokeRadius, height: borderWidth))
            path.close()
            
            path.lineWidth = borderWidth
            path.lineJoinStyle = .miter
            borderColor?.setStroke()
            path.stroke()
            
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image;
    }
    
    
    public func cornerImage(fillColor: UIColor = .clear) -> UIImage? {
        let size = self.size
        let radius = size.height / 2
        
        //利用绘图建立上下文
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        //设置填充颜色
//        fillColor.setFill()
//        UIRectFill(rect)
        
        //利用贝塞尔路径裁切
        let path = UIBezierPath.init(roundedRect: rect, cornerRadius: radius)
        path.addClip()
        self.draw(in: rect)
        
        //获取结果
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    
    
    
    
    
    
    
}
