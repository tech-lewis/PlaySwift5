//
//  MainNavigationViewController.swift
//  RCT
//
//  Created by mac on 15.11.20.
//  Copyright © 2020 Mark. All rights reserved.
//
import UIKit
class MainNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    func setupUI() {
        // 设置主题色
        self.navigationBar.tintColor = UIColor.init(red: 255/255.0, green: 119/255.0, blue: 0/255.0, alpha: 1)
    }
}
