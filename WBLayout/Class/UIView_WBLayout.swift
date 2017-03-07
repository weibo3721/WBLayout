//
//  UIView_WBLayout.swift
//  WBLayout
//
//  Created by weibo on 2017/3/6.
//  Copyright © 2017年 weibo. All rights reserved.
//

import UIKit
import Foundation
import PureLayout

//WBLayout
extension UIView {
    var wbLayoutKey:UnsafeMutableRawPointer  {
        get {
            return UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        }
    }
    
    var wbLayout:WBLayout {
        get {
            if let obj = objc_getAssociatedObject(self, wbLayoutKey) as? WBLayout {
                return obj
            }
            return WBLayout(view: self)
        }
        set {
            objc_setAssociatedObject(self, wbLayoutKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var wbLayouts:[WBLayoutEnum] {
        get {
            return wbLayout.getLayouts
        }
    }
    
    var wbLayoutviews:[UIView] {
        get {
            return wbLayout.getLayoutviews
        }
    }
    
    //MARK: 视图操作方法
    func wbAddLayoutView(newView:UIView) {
        wbLayout.addLayoutView(newView: newView)
    }
    
    func wbGoneView(thisView:UIView) {
        wbLayout.goneView(thisView: thisView)
    }
    
    func wbSetLayoutViews(arr:[UIView]) {
        wbLayout.setLayoutViews(arr: arr)
    }
    
    func wbClearlayout() {
        wbLayout.clearlayout()
    }
    
    func wbDeleteBottomEdge() {
        wbLayout.deleteBottomEdge()
    }
    
    func wbSetMode(newMode: WBLayoutModeEnum) {
        wbLayout.setMode(newMode: newMode)
    }
    
    func wbAddlayoutConstraint(constraint: NSLayoutConstraint) {
        wbLayout.addlayoutConstraint(constraint: constraint)
    }
    
    //MARK: 自动布局方法
    func wbHeight(size:CGFloat,_ relation:NSLayoutRelation = .equal) -> UIView {
        return wbLayout.wbHeight(size:size, relation)
    }
    
    func wbWidth(size:CGFloat,_ relation:NSLayoutRelation = .equal) -> UIView {
        return wbLayout.wbWidth(size:size, relation)
    }
    
    func wbPinEdge(edge:ALEdge,_ size:CGFloat = 0,_ relation:NSLayoutRelation = .equal) -> UIView  {
        return wbLayout.wbPinEdge(edge: edge, size, relation)
    }
    
    func wbAxis(axis:ALAxis) ->UIView {
        return wbLayout.wbAxis(axis: axis)
    }
    
    func wbVertical() ->UIView {
        return  self.wbAxis(axis: ALAxis.vertical)
    }
    
    func wbHorizontal() -> UIView {
        return self.wbAxis(axis: ALAxis.horizontal)
    }
    
    func wbLayoutSubviews() {
        wbLayout.wbLayoutSubviews()
    }
}
