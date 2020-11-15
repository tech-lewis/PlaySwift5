//
//  BIndMobileViewController.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/31.
//


import UIKit
import ApplicationKit

class BIndMobileViewController: UIViewController {

  private let mobileInpuView = SecurityInputView()
  private let verifyInputView = SecurityInputView()
  private let invitationCodeInputView = SecurityInputView()
  private let agreeCheckView = RegisterAgreementCheckView()
  private let confirmButton = GradientButton(type: .custom)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    view.bringSubviewToFront(navigationView)
    
  }
  
}

// MARK: - Public
extension BIndMobileViewController {
  

}

// MARK: - Setup
private extension BIndMobileViewController {
  
  func setupUI() {
    
    navigationView.setup(title: "绑定手机号")
    navigationView.showBack()
    
    let jumpButton = UIButton(type: .custom)
    jumpButton.setTitle("跳过", for: .normal)
    jumpButton.setTitleColor(Color.textOfLight, for: .normal)
    jumpButton.titleLabel?.font = Font.pingFangSCMedium(15)
    jumpButton.addTarget(self, action: #selector(clickJump(_:)), for: .touchUpInside)
    navigationView.addRight(UIBarButtonItem(customView: jumpButton))
    
    navigationView.setupShadow()
    
    view.backgroundColor = .white
    
    mobileInpuView.style = .mobile
    view.addSubview(mobileInpuView)
    mobileInpuView.layout.add { (make) in
      make.top(15).equal(navigationView).bottom()
      make.leading().trailing().equal(view)
      make.height(45)
    }
    
    verifyInputView.style = .verify
    verifyInputView.delegate = self
    view.addSubview(verifyInputView)
    verifyInputView.layout.add { (make) in
      make.top(15).equal(mobileInpuView).bottom()
      make.leading().trailing().equal(view)
      make.height(45)
    }
    
    invitationCodeInputView.style = .invitationCode
    view.addSubview(invitationCodeInputView)
    invitationCodeInputView.layout.add { (make) in
      make.top(15).equal(verifyInputView).bottom()
      make.leading().trailing().equal(view)
      make.height(45)
    }
    
    view.addSubview(agreeCheckView)
    agreeCheckView.layout.add { (make) in
      make.top(15).equal(invitationCodeInputView).bottom()
      make.leading().greaterThanOrEqual(view)
      make.trailing().lessThanOrEqual(view)
      make.centerX().equal(view)
    }
    
    confirmButton.setTitle("确定", for: .normal)
    confirmButton.setTitleColor(.white, for: .normal)
    confirmButton.titleLabel?.font = Font.pingFangSCMedium(14)
    confirmButton.colors = Color.gradientOrange
    confirmButton.gradientLayer.cornerRadius = 20
    confirmButton.setupShadow(Color.textOfOrange, shadowOffset: CGSize(width: 0, height: 3), shadowRadius: 4, shadowOpacity: 0.5)
    view.addSubview(confirmButton)
    confirmButton.layout.add { (make) in
      make.top(75).equal(invitationCodeInputView).bottom()
      make.centerX().equal(view)
      make.width(275).height(40)
    }
    
  }
  
  func updateUI() {
    
  }
  
}

// MARK: - Action
private extension BIndMobileViewController {
  
  @objc func clickJump(_ sender: UIButton) {
    
  }
  
}

// MARK: - Utiltiy
private extension BIndMobileViewController {
  
}

// MARK: - SecurityInputViewDelegate
extension BIndMobileViewController: SecurityInputViewDelegate {
  
  func securityInputView(_ view: SecurityInputView, sendVerifyCodeResult handle: @escaping (Bool) -> Void) {
    
    handle(true)
    
  }
  
}
