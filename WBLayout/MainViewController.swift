//
//  MainViewController.swift
//  WBLayout
//
//  Created by weibo on 2017/3/7.
//  Copyright © 2017年 weibo. All rights reserved.
//

import UIKit
import Foundation

class MainViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button1 = UIButton()
        button1.setTitle("查看垂直布局", for: UIControlState.normal)
        button1.addTarget(self, action: #selector(MainViewController.onClickButton1), for: UIControlEvents.touchUpInside)
        button1.backgroundColor = UIColor.purple
        button1.wbPinEdge(edge: .top,64).wbPinEdge(edge: .left,15).wbPinEdge(edge: .right,15)
        
        let button2 = UIButton()
        button2.setTitle("查看水平布局", for: UIControlState.normal)
        button2.addTarget(self, action: #selector(MainViewController.onClickButton2), for: UIControlEvents.touchUpInside)
        button2.backgroundColor = UIColor.brown
        button2.wbPinEdge(edge: .top,15).wbPinEdge(edge: .left,15).wbPinEdge(edge: .right,15)
        
        view.wbSetLayoutViews(arr: [button1,button2])
        view.wbLayoutSubviews()
    }
    
    func onClickButton1() {
        let vc = ViewControllerV()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func onClickButton2() {
        let vc = ViewControllerH()
        navigationController?.pushViewController(vc, animated: true)
    }
}
