//
//  ComposeTitleView.swift
//  XMGWB
//
//  Created by xiaomage on 15/11/16.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

class ComposeTitleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI()
    {
        addSubview(titleLabel)
        addSubview(nameLabel)
        
        titleLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self)
            make?.centerX.equalTo()(self)
        }
        nameLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(self.titleLabel.mas_bottom)
        }
    }
    
    
    // MARK: - 懒加载
    private lazy var titleLabel: UILabel = {
       let lb = UILabel()
        lb.textColor = UIColor.darkGray
        lb.text = "发微博"
        return lb
    }()
    
    private lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.lightGray
        lb.font = UIFont.systemFont(ofSize: 15)
        //lb.text = UserAccount.loadUserAccount()?.screen_name ?? ""
        lb.text = ""
        return lb
    }()
}
