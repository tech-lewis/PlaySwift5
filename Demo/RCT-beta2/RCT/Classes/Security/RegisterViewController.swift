//
//  RegisterViewController.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/31.
//

import UIKit
import ApplicationKit

class RegisterViewController: UIViewController {

  private let mobileInpuView = SecurityInputView()
  private let verifyInputView = SecurityInputView()
  private let passwordInputView = SecurityInputView()
  private let invitationCodeInputView = SecurityInputView()
  private let agreeCheckView = RegisterAgreementCheckView()
  private let registerButton = GradientButton(type: .custom)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    view.bringSubviewToFront(navigationView)
    
  }
  
}

// MARK: - Public
extension RegisterViewController {
  

}

// MARK: - Setup
private extension RegisterViewController {
  
  func setupUI() {
    
    navigationView.setup(title: "注册")
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
    
    passwordInputView.style = .password
    view.addSubview(passwordInputView)
    passwordInputView.layout.add { (make) in
      make.top(15).equal(verifyInputView).bottom()
      make.leading().trailing().equal(view)
      make.height(45)
    }
    
    invitationCodeInputView.style = .invitationCode
    view.addSubview(invitationCodeInputView)
    invitationCodeInputView.layout.add { (make) in
      make.top(15).equal(passwordInputView).bottom()
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
    
    registerButton.setTitle("注册", for: .normal)
    registerButton.setTitleColor(.white, for: .normal)
    registerButton.titleLabel?.font = Font.pingFangSCMedium(14)
    registerButton.colors = Color.gradientOrange
    registerButton.gradientLayer.cornerRadius = 20
    registerButton.setupShadow(Color.textOfOrange, shadowOffset: CGSize(width: 0, height: 3), shadowRadius: 4, shadowOpacity: 0.5)
    view.addSubview(registerButton)
    registerButton.layout.add { (make) in
      make.top(75).equal(invitationCodeInputView).bottom()
      make.centerX().equal(view)
      make.width(275).height(40)
    }
    
  }
  
  func updateUI() {
    
  }
  
}

// MARK: - Action
private extension RegisterViewController {
  
}

// MARK: - Utiltiy
private extension RegisterViewController {
  
}

// MARK: - SecurityInputViewDelegate
extension RegisterViewController: SecurityInputViewDelegate {
  
  func securityInputView(_ view: SecurityInputView, sendVerifyCodeResult handle: @escaping (Bool) -> Void) {
    
    handle(true)
    
  }
  
}
