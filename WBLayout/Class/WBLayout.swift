//
//  WBLayout.swift
//  weibo
//
//  Created by weibo on 16/7/20.
//  Copyright © 2016年 weibo. All rights reserved.
//

import UIKit
import Foundation
import PureLayout

enum WBLayoutEnum {
    case Dimension(ALDimension,CGFloat,NSLayoutRelation)
    case Axis(ALAxis)
    case PinEdge(ALEdge,CGFloat,NSLayoutRelation)
}

enum WBLayoutModeEnum {
    case Vertical
    case Horizontal
}

class WBLayout {
    private weak var myView:UIView!
    
    private var layouts = [WBLayoutEnum]()
    
    private var layoutviews = [UIView]()
    
    private var layoutConstraints = [NSLayoutConstraint]()
    
    private var mode = WBLayoutModeEnum.Vertical
    
    var getLayouts:[WBLayoutEnum] {
        get {
            return layouts
        }
    }
    
    var getLayoutviews:[UIView] {
        get {
            return layoutviews
        }
    }
    
    init(view:UIView) {
        myView = view
        myView.wbLayout = self
    }
    
    func setMode(newMode:WBLayoutModeEnum) {
        self.mode = newMode
    }
    
    func addLayoutView(newView:UIView) {
        layoutviews.append(newView)
    }
    
    func goneView(thisView:UIView) {
        thisView.removeFromSuperview()
        if let index = layoutviews.index(of: thisView) {
            layoutviews.remove(at: index)
        }
    }
    
    func setLayoutViews(arr:[UIView]) {
        layoutviews = arr
    }
    
    func clearlayout() {
        layouts = []
    }
    
    func deleteBottomEdge() {
        layouts = layouts.filter({ (WBLayoutEnum) -> Bool in
            switch WBLayoutEnum {
            case .Dimension(_, _, _):
                return true
            case .PinEdge(let edge, _, _):
                switch edge {
                case .top:
                    return true
                case .bottom:
                    return false
                default:
                    return true
                }
            case .Axis(_):
                return true
            }
        })
    }
    
    func wbHeight(size:CGFloat,_ relation:NSLayoutRelation = .equal) -> UIView {
        layouts.append(WBLayoutEnum.Dimension(.height, size, relation))
        return self.myView
    }
    
    func wbWidth(size:CGFloat,_ relation:NSLayoutRelation = .equal) -> UIView {
        layouts.append(WBLayoutEnum.Dimension(.width, size, relation))
        return self.myView
    }
    
    func wbPinEdge(edge:ALEdge,_ size:CGFloat = 0,_ relation:NSLayoutRelation = .equal) -> UIView  {
        layouts.append(WBLayoutEnum.PinEdge(edge, size, relation))
        return self.myView
    }
    
    func wbAxis(axis:ALAxis) ->UIView {
        layouts.append(WBLayoutEnum.Axis(axis))
        return self.myView
    }
    
    func wbLayoutSubviews() {
        
        self.myView.removeConstraints(self.layoutConstraints)
        layoutConstraints = []
        for view in layoutviews {
            view.removeFromSuperview()
            myView.addSubview(view)
        }
        for view in layoutviews {
            for item in view.wbLayouts {
                switch item {
                case .Dimension(let dimension, let size, let relation):
                    layoutConstraints.append(view.autoSetDimension(dimension, toSize: size, relation: relation))
                    break
                case .PinEdge(let edge, let size, let relation):
                    if mode == .Vertical {
                        switch edge {
                        case .top:
                            if view == layoutviews.first {
                                layoutConstraints.append(view.autoPinEdge(toSuperviewEdge: .top, withInset: size,relation: relation))
                            }
                            else {
                                if let beforeview = beforeView(thisView: view) {
                                    layoutConstraints.append(view.autoPinEdge(.top, to: .bottom, of: beforeview, withOffset: size, relation:  relation))
                                }
                            }
                        case .bottom:
                            if view == layoutviews.last {
                                layoutConstraints.append(view.autoPinEdge(toSuperviewEdge: .bottom, withInset: size,relation: relation))
                            }
                            else {
                                if let afterview = afterView(thisView: view) {
                                    layoutConstraints.append(view.autoPinEdge(.top, to: .bottom, of: afterview, withOffset: size, relation:  relation))
                                }
                            }
                        default:
                            layoutConstraints.append(view.autoPinEdge(toSuperviewEdge: edge,withInset: size))
                        }
                        break
                    }
                    else {
                        switch edge {
                        case .left:
                            if view == layoutviews.first {
                                layoutConstraints.append(view.autoPinEdge(toSuperviewEdge: .left, withInset: size,relation: relation))
                            }
                            else {
                                if let beforeview = beforeView(thisView: view) {
                                    layoutConstraints.append(view.autoPinEdge(.left, to: .right, of: beforeview, withOffset: size, relation:  relation))
                                }
                            }
                        case .right:
                            if view == layoutviews.last {
                                layoutConstraints.append(view.autoPinEdge(toSuperviewEdge: .right, withInset: size,relation: relation))
                            }
                            else {
                                if let afterview = afterView(thisView: view) {
                                    layoutConstraints.append(view.autoPinEdge(.left, to: .right, of: afterview, withOffset: size, relation:  relation))
                                }
                            }
                        default:
                            layoutConstraints.append(view.autoPinEdge(toSuperviewEdge: edge,withInset: size))
                        }
                        break
                    }
                case .Axis(let axis):
                    layoutConstraints.append(view.autoAlignAxis(toSuperviewAxis: axis))
                    break
                }
            }
            view.wbLayoutSubviews()
        }
    }
    
    func beforeView(thisView:UIView) -> UIView? {
        if let index = layoutviews.index(of: thisView) {
            if (index - 1) >= 0 && (index - 1) < layoutviews.count {
                return layoutviews[index - 1]
            }
        }
        return nil
    }
    
    func afterView(thisView:UIView) -> UIView? {
        if let index = layoutviews.index(of: thisView) {
            if (index + 1) >= 0 && (index + 1) < layoutviews.count {
                return layoutviews[index + 1]
            }
        }
        return nil
    }
}
