//
//  CYCellModel.swift
//  ZAKER Pro
//
//  Created by 红鹊豆 on 2018/2/5.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

protocol isP {
    func getSize(p: CGFloat?, l: CGFloat?) -> CGFloat?
//    func setSize(p: CGFloat?, l: CGFloat?, newValue: CGFloat?)
    func getFrame(p: CGRect?, l: CGRect?) -> CGRect?
}

class CYCellModel: NSObject,isP {
    func getFrame(p: CGRect?, l: CGRect?) -> CGRect? {
        if CYDevice.width() < CYDevice.height() {
            return p
        } else {
            return l
        }
    }
    
    func getSize(p: CGFloat?, l: CGFloat?) -> CGFloat? {
        if CYDevice.width() < CYDevice.height() {
            return p
        } else {
            return l
        }
    }
    
    
    // ---------------------- cell高度 ----------------------
    public var cellHeight    : CGFloat? {
        get {
            return getSize(p: self.pCellHeight, l: self.lCellHeight)
        }
        set {
            if CYDevice.width() < CYDevice.height() {
                self.pCellHeight = newValue
            } else {
                self.lCellHeight = newValue
            }
        }
    }
    private var pCellHeight    : CGFloat?  // 竖屏高度
    private var lCellHeight    : CGFloat?  // 横屏高度
    
    // ---------------------- 标题高度 ----------------------
    public var titleHeight   : CGFloat? {
        get {
            return getSize(p: self.pTitleHeight, l: self.lTitleHeight)
        }
        set {
            if CYDevice.width() < CYDevice.height() {
                self.pTitleHeight = newValue
            } else {
                self.lTitleHeight = newValue
            }
        }
    }
    private var pTitleHeight    : CGFloat?  // 竖屏高度
    private var lTitleHeight    : CGFloat?  // 横屏高度
    
    // ---------------------- 副标题高度 ----------------------
    public var subTitleHeight: CGFloat? {
        get {
            return getSize(p: self.pSubTitleHeight, l: self.lSubTitleHeight)
        }
        set {
            if CYDevice.width() < CYDevice.height() {
                self.pSubTitleHeight = newValue
            } else {
                self.lSubTitleHeight = newValue
            }
        }
    }
    
    private var pSubTitleHeight    : CGFloat?  // 竖屏高度
    private var lSubTitleHeight    : CGFloat?  // 横屏高度
    
    // ---------------------- 标题frame ----------------------
    public var titleFrame: CGRect? {
        get {
            return getFrame(p: self.pTitleFrame, l: self.lTitleFrame)
        }
        set {
            if CYDevice.width() < CYDevice.height() {
                self.pTitleFrame = newValue
            } else {
                self.lTitleFrame = newValue
            }
        }
    }
    private var pTitleFrame    : CGRect?
    private var lTitleFrame    : CGRect?
    
    // ---------------------- 副标题frame ----------------------
    public var subTitleFrame: CGRect? {
        get {
            return getFrame(p: self.pSubTitleFrame, l: self.lSubTitleFrame)
        }
        set {
            if CYDevice.width() < CYDevice.height() {
                self.pSubTitleFrame = newValue
            } else {
                self.lSubTitleFrame = newValue
            }
        }
    }
    
    private var pSubTitleFrame    : CGRect?
    private var lSubTitleFrame    : CGRect?
    
    // ---------------------- 备用frame ----------------------
    public var standbyFrame: CGRect? {
        get {
            return getFrame(p: self.pStandbyFrame, l: self.lStandbyFrame)
        }
        set {
            if CYDevice.width() < CYDevice.height() {
                self.pStandbyFrame = newValue
            } else {
                self.lStandbyFrame = newValue
            }
        }
    }
    
    private var pStandbyFrame    : CGRect?
    private var lStandbyFrame    : CGRect?
    
    var firstShow   : Bool = false  // 第一次显示
    var isClick     : Bool = false  // 是否点击过
    
    override init() {
        super.init()
    }
    
}
