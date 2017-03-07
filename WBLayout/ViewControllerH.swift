//
//  ViewControllerH.swift
//  WBLayout
//
//  Created by weibo on 2017/3/7.
//  Copyright © 2017年 weibo. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerH : UIViewController {
    let view1 = UIButton()
    let viewRed = UILabel()
    let viewYellow = UILabel()
    let viewBlue = UILabel()
    
    let view2 = UIButton()
    let v2s1 = UIView()
    let v2s2 = UILabel()
    let v2s3 = UIView()
    
    let view3 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        addLayoutForView1()
        addLayoutForView2()
        addLayoutForView3()
        
        view.wbAddLayoutView(newView: view1)
        view.wbAddLayoutView(newView: view2)
        view.wbAddLayoutView(newView: view3)
        view.wbLayoutSubviews()
    }
    
    func addLayoutForView1() {
        view1.addTarget(self, action: #selector(ViewControllerV.onClickChangeText), for: UIControlEvents.touchUpInside)
        view1.backgroundColor = UIColor.black
        view1.wbPinEdge(edge: .top,64).wbPinEdge(edge: .left).wbHeight(size: 150)
        view1.wbSetMode(newMode: .Horizontal)
        
        
        viewRed.text = "viewRed"
        viewRed.numberOfLines = 0
        viewRed.backgroundColor = UIColor.red
        viewRed.wbPinEdge(edge: .left,15).wbAxis(axis: .horizontal)
        
        
        viewYellow.text = "viewYellow"
        viewYellow.backgroundColor = UIColor.yellow
        viewYellow.wbPinEdge(edge: .left,15).wbAxis(axis: .horizontal)
        
        
        viewBlue.text = "viewBlue\nline2"
        viewBlue.backgroundColor = UIColor.blue
        viewBlue.wbAxis(axis: .horizontal).wbPinEdge(edge: .left,15).wbPinEdge(edge: .right,15).wbPinEdge(edge: .bottom,15)
        
        
        view1.wbSetLayoutViews(arr: [viewRed,viewYellow,viewBlue])
    }
    
    func addLayoutForView2() {
        view2.addTarget(self, action: #selector(ViewControllerV.onClickRemove), for: UIControlEvents.touchUpInside)
        view2.backgroundColor = UIColor.purple
        view2.wbPinEdge(edge: .top,20).wbPinEdge(edge: .left).wbHeight(size: 90)
        view2.wbSetMode(newMode: .Horizontal)
        
        v2s1.backgroundColor = UIColor.red
        v2s1.isUserInteractionEnabled = false
        v2s1.wbAxis(axis: .horizontal).wbPinEdge(edge: .left,15).wbHeight(size: 30).wbWidth(size: 30)
        
        
        v2s2.text = "点击后这个区域会消失,再次点击显示"
        v2s2.numberOfLines = 0
        v2s2.backgroundColor = UIColor.yellow
        v2s2.isUserInteractionEnabled = false
        v2s2.wbAxis(axis: .horizontal).wbPinEdge(edge: .left,15).wbWidth(size: 200)
        
        v2s3.backgroundColor = UIColor.blue
        v2s3.isUserInteractionEnabled = false
        v2s3.wbAxis(axis: .horizontal).wbPinEdge(edge: .left,15).wbPinEdge(edge: .right,15).wbHeight(size: 30).wbWidth(size: 30)
        
        view2.wbSetLayoutViews(arr: [v2s1,v2s2,v2s3])
    }
    
    func addLayoutForView3() {
        view3.text = "黑色块点击用于演示文字改变的布局更新\n紫色块点击用于演示view的添加和删除时,布局的更新"
        view3.numberOfLines = 0
        view3.backgroundColor = UIColor.green
        view3.wbPinEdge(edge: .top,30).wbPinEdge(edge: .left).wbPinEdge(edge: .right)
    }
    
    
    var isChanged = false
    
    func onClickChangeText() {
        isChanged = !isChanged
        if isChanged {
            viewRed.text = "viewRedline1\nline2"
        }
        else {
            viewRed.text = "viewRed"
        }
        
        view.wbLayoutSubviews()
    }
    
    var isRemove = false
    
    func onClickRemove() {
        isRemove = !isRemove
        if isRemove {
            view2.wbGoneView(thisView: v2s2)
        }
        else {
            view2.wbSetLayoutViews(arr: [v2s1,v2s2,v2s3])
        }
        
        view.wbLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
