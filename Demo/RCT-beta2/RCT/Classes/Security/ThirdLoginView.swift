//
//  ThirdLoginView.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/27.
//

import UIKit
import ApplicationKit
import AuthenticationServices

protocol ThirdLoginViewDelegate: class {
  
  func loginWith(type: ThirdLoginView.LoginType)
  
}

class ThirdLoginView: UIView {
  
  enum LoginType {
    case wechat
    case appleId
  }
  
  weak var delegate: ThirdLoginViewDelegate?
  
  private let leftLineView = GradientView()
  private let titleLabel = UILabel()
  private let rightLineView = GradientView()
  
  private let stackView = UIStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Public
extension ThirdLoginView {
  
}

// MARK: - Action
private extension ThirdLoginView {
  
  @objc func clickWXLogin() {
    
    delegate?.loginWith(type: .wechat)
    
  }
  
  @objc func clickAppliIdLogin() {
    
    delegate?.loginWith(type: .appleId)
    
  }
  
}

// MARK: - Setup
private extension ThirdLoginView {
  
  func setupUI() {
    
    leftLineView.colors = [UIColor.white.cgColor, Color.textOfLight.cgColor]
    addSubview(leftLineView)
    leftLineView.layout.add { (make) in
      make.leading(20).equal(self)
      make.height(1)
    }
    
    titleLabel.text = "第三方登录"
    titleLabel.textColor = Color.textOfLight
    titleLabel.font = Font.pingFangSCMedium(12)
    addSubview(titleLabel)
    titleLabel.layout.add { (make) in
      make.leading(15).equal(leftLineView).trailing()
      make.top().centerX().equal(self)
      make.hugging(axis: .horizontal)
      make.centerY().equal(leftLineView)
    }
    
    rightLineView.colors = [Color.textOfLight.cgColor, UIColor.white.cgColor]
    addSubview(rightLineView)
    rightLineView.layout.add { (make) in
      make.leading(15).equal(titleLabel).trailing()
      make.centerY().equal(titleLabel)
      make.trailing(-20).equal(self)
      make.height(1)
    }
    
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 40
    addSubview(stackView)
    stackView.layout.add { (make) in
      make.top(30).equal(titleLabel).bottom()
      make.leading().greaterThanOrEqual(self)
      make.trailing().lessThanOrEqual(self)
      make.centerX().equal(self)
      make.bottom().equal(self)
    }
    
    stackView.addArrangedSubview(UIView())
//    if #available(iOS 13.0, *) {
     
      stackView.addArrangedSubview(setupItem(icon: "security_apple", title: "Apple ID", action: #selector(clickWXLogin)))
      stackView.addArrangedSubview(UIView())
//    }
    
//    if OpenManager.isInstallWeChat() {
      stackView.addArrangedSubview(setupItem(icon: "security_wx", title: "微信", action: #selector(clickWXLogin)))
      stackView.addArrangedSubview(UIView())
//    }
    
  }
  
  func setupItem(icon: String, title: String, action: Selector) -> UIButton {
    
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
    button.setImage(UIImage(named: icon), for: .normal)
    button.setTitle(title, for: .normal)
    button.setTitleColor(Color.textOfDeep, for: .normal)
    button.titleLabel?.font = Font.pingFangSCMedium(12)
    button.addTarget(self, action: action, for: .touchUpInside)
    button.setImage(position: .top, with: 5)
    return button
  }
  
}
