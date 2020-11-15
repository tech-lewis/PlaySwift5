//
//  ForgetPasswordViewController.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/31.
//

import UIKit
import ApplicationKit

class ForgetPasswordViewController: UIViewController {

  private let mobileInpuView = SecurityInputView()
  private let verifyInputView = SecurityInputView()
  private let passwordInputView = SecurityInputView()
  private let confirmButton = GradientButton(type: .custom)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    view.bringSubviewToFront(navigationView)
    
  }
  
}

// MARK: - Public
extension ForgetPasswordViewController {
  

}

// MARK: - Setup
private extension ForgetPasswordViewController {
  
  func setupUI() {
    
    navigationView.setup(title: "忘记密码")
    navigationView.showBack()
    
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
    
    passwordInputView.style = .newPassword
    view.addSubview(passwordInputView)
    passwordInputView.layout.add { (make) in
      make.top(15).equal(verifyInputView).bottom()
      make.leading().trailing().equal(view)
      make.height(45)
    }
    
    confirmButton.setTitle("确定", for: .normal)
    confirmButton.setTitleColor(.white, for: .normal)
    confirmButton.titleLabel?.font = Font.pingFangSCMedium(14)
    confirmButton.colors = Color.gradientOrange
    confirmButton.gradientLayer.cornerRadius = 20
    confirmButton.setupShadow(Color.textOfOrange, shadowOffset: CGSize(width: 0, height: 3), shadowRadius: 4, shadowOpacity: 0.5)
    view.addSubview(confirmButton)
    confirmButton.layout.add { (make) in
      make.top(40).equal(passwordInputView).bottom()
      make.centerX().equal(view)
      make.width(275).height(40)
    }
    
  }
  
  func updateUI() {
    
  }
  
}

// MARK: - Action
private extension ForgetPasswordViewController {
  
}

// MARK: - Utiltiy
private extension ForgetPasswordViewController {
  
}

// MARK: - SecurityInputViewDelegate
extension ForgetPasswordViewController: SecurityInputViewDelegate {
  
  func securityInputView(_ view: SecurityInputView, sendVerifyCodeResult handle: @escaping (Bool) -> Void) {
    
    handle(true)
    
  }
  
}
