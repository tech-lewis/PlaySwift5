//
//  LoginViewController.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/27.
//

import UIKit
import ApplicationKit

class LoginViewController: UIViewController {

  private let titleLabel = UILabel()
  private let teacherApplyButton = UIButton(type: .custom)
  private let mobileInpuView = SecurityInputView()
  private let verifyInputView = SecurityInputView()
  private let loginButton = GradientButton(type: .custom)
  private let registerButton = UIButton(type: .custom)
  private let passwordLoginButton = UIButton(type: .custom)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    
  }
  
}

// MARK: - Public
extension LoginViewController {
  
  static func show() {
    
    let viewController = LoginViewController()
    Presenter.present(UINavigationController(rootViewController: viewController))
    
  }
  
}

// MARK: - Setup
private extension LoginViewController {
  
  func setupUI() {
    
    navigationView.setup(title: "")
    navigationView.showBack()
    
    view.backgroundColor = .white
    
    titleLabel.text = "手机验证码登录"
    titleLabel.font = Font.pingFangSCSemibold(20)
    titleLabel.textColor = Color.textOfDeep
    view.addSubview(titleLabel)
    titleLabel.layout.add { (make) in
      make.leading(20).equal(view)
      make.top(20).equal(navigationView).bottom()
    }
    
    teacherApplyButton.setTitle("成为教员", for: .normal)
    teacherApplyButton.setTitleColor(Color.textOfLight, for: .normal)
    teacherApplyButton.titleLabel?.font = Font.pingFangSCMedium(14)
    teacherApplyButton.setImage(UIImage(named: "arrow_right"), for: .normal)
    teacherApplyButton.setImage(position: .right, with: 6)
    view.addSubview(teacherApplyButton)
    teacherApplyButton.layout.add { (make) in
      make.leading().greaterThanOrEqual(titleLabel).trailing()
      make.trailing(-20).equal(view)
      make.centerY().equal(titleLabel)
    }
    
    mobileInpuView.style = .mobile
    view.addSubview(mobileInpuView)
    mobileInpuView.layout.add { (make) in
      make.top(24).equal(titleLabel).bottom()
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
    
    loginButton.setTitle("登录", for: .normal)
    loginButton.setTitleColor(.white, for: .normal)
    loginButton.titleLabel?.font = Font.pingFangSCMedium(14)
    loginButton.colors = Color.gradientOrange
    loginButton.gradientLayer.cornerRadius = 20
    loginButton.setupShadow(Color.textOfOrange, shadowOffset: CGSize(width: 0, height: 3), shadowRadius: 4, shadowOpacity: 0.5)
    view.addSubview(loginButton)
    loginButton.layout.add { (make) in
      make.top(50).equal(verifyInputView).bottom()
      make.centerX().equal(view)
      make.width(275).height(40)
    }
    
    let registerStackView = UIStackView()
    registerStackView.axis = .horizontal
    registerStackView.spacing = 0
    registerStackView.alignment = .center
    view.addSubview(registerStackView)
    registerStackView.layout.add { (make) in
      make.top(5).equal(loginButton).bottom()
      make.centerX().equal(view)
    }
    
    registerButton.setTitle("注册", for: .normal)
    registerButton.setTitleColor(Color.textOfLight, for: .normal)
    registerButton.titleLabel?.font = Font.pingFangSCMedium(13)
    registerButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    registerButton.addTarget(self, action: #selector(clickRegistser(_:)), for: .touchUpInside)
    registerStackView.addArrangedSubview(registerButton)
    
    let lineView = UIView()
    lineView.backgroundColor = Color.textOfLight
    lineView.layout.add { (make) in
      make.width(1).height(16)
    }
    registerStackView.addArrangedSubview(lineView)
    
    passwordLoginButton.setTitle("密码登录", for: .normal)
    passwordLoginButton.setTitleColor(Color.textOfLight, for: .normal)
    passwordLoginButton.titleLabel?.font = Font.pingFangSCMedium(13)
    passwordLoginButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    passwordLoginButton.addTarget(self, action: #selector(clickPasswordLogin(_:)), for: .touchUpInside)
    registerStackView.addArrangedSubview(passwordLoginButton)
    
    let thirdView = ThirdLoginView()
    thirdView.delegate = self
    view.addSubview(thirdView)
    thirdView.layout.add { (make) in
      make.top().greaterThanOrEqual(registerStackView).bottom()
      make.leading().trailing().equal(view)
      make.bottom(-50).equal(view).safeBottom()
    }
    
  }
  
  func updateUI() {
    
  }
  
}

// MARK: - Action
private extension LoginViewController {
  
  @objc func clickPasswordLogin(_ sender: UIButton) {
    
    Presenter.push(PasswordLoginViewController())
    
  }
  
  @objc func clickRegistser(_ sender: UIButton) {
    
    Presenter.push(RegisterViewController())
    
  }
  
}

// MARK: - Utiltiy
private extension LoginViewController {
  
}

// MARK: - SecurityInputViewDelegate
extension LoginViewController: SecurityInputViewDelegate {
  
  func securityInputView(_ view: SecurityInputView, sendVerifyCodeResult handle: @escaping (Bool) -> Void) {
    
    handle(true)
    
  }
  
}

extension LoginViewController: ThirdLoginViewDelegate {
  
  func loginWith(type: ThirdLoginView.LoginType) {
    
    let viewController = BIndMobileViewController()
    Presenter.push(viewController)
    
  }
    
}
