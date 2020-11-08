//
//  ComposeTextView.swift
//  XMGWB
//
//  Created by xiaomage on 15/11/16.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView, UITextViewDelegate {
    
    init()
    {
        super.init(frame: .zero, textContainer: nil)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 内部控制方法
    private func setupUI()
    {
        // 1.添加子控件
        addSubview(placeholderLabel)
        
        // 2.布局子控件
        placeholderLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(5)
            make?.top.equalTo()(8)
        }
        
        // 3.监听UITextView内容改变
        NotificationCenter.default.addObserver(self, selector: #selector(textChange), name: Notification.Name.UITextViewTextDidChange, object: self)
    }
    // 监听UITextView内容改变
    @objc private func textChange()
    {
        placeholderLabel.isHidden = self.hasText
    }
        
    // MARK: - 懒加载
    private lazy var placeholderLabel: UILabel = {
       let lb = UILabel()
        lb.text = "分享新鲜事..."
        lb.textColor = UIColor.lightGray
        lb.font = self.font
        return lb
    }()
}
