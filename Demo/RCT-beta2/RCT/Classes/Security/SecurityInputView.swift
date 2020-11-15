//
//  SecurityInputView.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/27.
//

import UIKit
import ApplicationKit

protocol SecurityInputViewDelegate: class {
  
  /// 点击发送验证码事件
  ///
  /// - Parameters:
  ///   - view: SecurityInputView
  ///   - handle: 发送验证码是否成功
  func securityInputView(_ view: SecurityInputView, sendVerifyCodeResult handle: @escaping (_ isSuccess: Bool) -> Void)
  
}

class SecurityInputView: UIView {
  
  weak var delegate: SecurityInputViewDelegate?
  
  var placeholder: String? {
    set { update(placeholder: newValue) }
    get { return textField.placeholder }
  }
  
  var content: String? { return textField.text }
  
  var style: Style = .none { didSet { updateAppearance() } }
  
  private let textField = UITextField()
  private let bottomLineView = UIView()
  private let rightButton = UIButton(type: .custom)
  
  private lazy var timer = CountDownTimer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
   
    NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: nil)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    
    NotificationCenter.default.removeObserver(self)
  }
  
  override var canBecomeFirstResponder: Bool {
    
    return textField.canBecomeFirstResponder
  }
  
  @discardableResult
  override func becomeFirstResponder() -> Bool {
    
    return textField.becomeFirstResponder()
  }
}

// MARK: - Public
extension SecurityInputView {
  
  enum Style {
    
    case none
    
    case mobile
    case password
    case newPassword
    case registerPassword
    case verify
    case invitationCode
    
  }
  
  func clear() {
    
    textField.text = nil
  }
  
}

// MARK: - Setup
private extension SecurityInputView {
  
  func setupUI() {
    
    //layer.borderColor = UIColor.white.cgColor
    //layer.borderWidth = 0.5
    
    rightButton.addTarget(self, action: #selector(clickRight), for: .touchUpInside)
    textField.rightView = rightButton
    
    textField.textColor = Color.textOfDeep
    textField.font = Font.pingFangSCSemibold(14)
    textField.clearButtonMode = .whileEditing
    textField.addTarget(self, action: #selector(beginEdit), for: .editingDidBegin)
    textField.addTarget(self, action: #selector(endEdit), for: .editingDidEnd)
    textField.showKeyboardToolBar()
    textField.keyboardType = .numberPad
    
    addSubview(textField)
    textField.layout.add { (make) in
      make.top().bottom().leading(20).trailing(-20).equal(self)
    }
    
    bottomLineView.backgroundColor = Color.grayBackground
    addSubview(bottomLineView)
    bottomLineView.layout.add { (make) in
      make.leading(15).trailing(-15).bottom().equal(self)
      make.height(1)
    }
  }
  
}

// MARK: - Action
private extension SecurityInputView {
  
  @objc func beginEdit(_ textField: UITextField) {
    

    
  }
  
  @objc func endEdit(_ textField: UITextField) {
    


  }
  
  @objc func clickRight(_ sender: UIButton) {
    
    switch style {
    case .verify:
      
      sender.isUserInteractionEnabled = false
      delegate?.securityInputView(self, sendVerifyCodeResult: { [weak self] (isSuccess) in
        
        sender.isUserInteractionEnabled = true
        if isSuccess == false { return }
        
        sender.isEnabled = false
        self?.timer.start(withDeadline: Date(timeInterval: 61, since: Date()), update: { (date) in
          
          guard let minute = date.minute else { return }
          guard let second = date.second else { return }
          sender.setTitle("\(minute * 60 + second)S", for: .disabled)
          
        }, timeEnd: {
          
          sender.isEnabled = true
          sender.setTitle("获取验证码", for: .disabled)
        })
      })
      
    case .password, .newPassword, .registerPassword:
      
      sender.isSelected = !sender.isSelected
      textField.isSecureTextEntry = sender.isSelected
      
    default: break
    }
    
  }
  
}

// MARK: - Utility
private extension SecurityInputView {
  
  func updateAppearance() {
    
    switch style {
    case .mobile:
      
      textField.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSAttributedString.Key.font: Font.pingFangSCMedium(14), NSAttributedString.Key.foregroundColor: Color.textOfLight])
      textField.leftViewMode = .always
      textField.keyboardType = .numberPad
      textField.isSecureTextEntry = false
      
    case .password:

      textField.attributedPlaceholder = NSAttributedString(string: "请输入登录密码", attributes: [NSAttributedString.Key.font: Font.pingFangSCMedium(14), NSAttributedString.Key.foregroundColor: Color.textOfLight])
      textField.leftViewMode = .always
      textField.keyboardType = .default
      setupPasswordSecurityModeButton()
      textField.isSecureTextEntry = true
    
    case .registerPassword:
    
      textField.attributedPlaceholder = NSAttributedString(string: "请设置登录密码", attributes: [NSAttributedString.Key.font: Font.pingFangSCMedium(14), NSAttributedString.Key.foregroundColor: Color.textOfLight])
      textField.leftViewMode = .always
      textField.keyboardType = .default
      setupPasswordSecurityModeButton()
      textField.isSecureTextEntry = true
      
    case .newPassword:
      
      textField.attributedPlaceholder = NSAttributedString(string: "请输入新密码", attributes: [NSAttributedString.Key.font: Font.pingFangSCMedium(14), NSAttributedString.Key.foregroundColor: Color.textOfLight])
      textField.leftViewMode = .always
      textField.keyboardType = .default
      setupPasswordSecurityModeButton()
      textField.isSecureTextEntry = true
      
    case .verify:
      
      textField.attributedPlaceholder = NSAttributedString(string: "请输入验证码", attributes: [NSAttributedString.Key.font: Font.pingFangSCMedium(14), NSAttributedString.Key.foregroundColor: Color.textOfLight])
      textField.leftViewMode = .always
      textField.keyboardType = .numberPad
      setupSendVerifyCodeButton()
      textField.isSecureTextEntry = false
    
    case .invitationCode:
      
      textField.attributedPlaceholder = NSAttributedString(string: "请输入邀请码(选填)", attributes: [NSAttributedString.Key.font: Font.pingFangSCMedium(14), NSAttributedString.Key.foregroundColor: Color.textOfLight])
      textField.leftViewMode = .always
      textField.keyboardType = .default
      textField.isSecureTextEntry = false
      
    case .none:
      
      textField.leftViewMode = .never
      textField.rightViewMode = .never
      textField.keyboardType = .default
      textField.isSecureTextEntry = false
    }
    
  }
  
  func update(placeholder: String?) {
    
    guard let placeholder = placeholder else { return }
    textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(0xdddddd), .font: Font.system(16)])
  }
  
  func setupPasswordSecurityModeButton() {
    
//    rightButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//    rightButton.setImage(UIImage(named: "security_password_visible"), for: .normal)
//    rightButton.setImage(UIImage(named: "security_password_invisible"), for: .selected)
//    rightButton.isSelected = true
//    rightButton.layout.add { (make) in
//      make.width(44).height(44)
//    }
//
//    textField.rightView = rightButton
//    textField.rightViewMode = .always
  }
  
  func setupSendVerifyCodeButton() {
    
    rightButton.frame = CGRect(x: 0, y: 0, width: 75, height: 45)
    rightButton.titleLabel?.font = Font.pingFangSCRegular(14)
    rightButton.setTitleColor(Color.textOfOrange, for: .normal)
    rightButton.setTitleColor(Color.textOfLight, for: .disabled)
    rightButton.setTitle("获取验证码", for: .normal)
    rightButton.addTarget(self, action: #selector(clickRight(_:)), for: .touchUpInside)
    rightButton.layout.add { (make) in
      make.width(75).height(45)
    }
    
    textField.rightView = rightButton
    textField.rightViewMode = .always
  }
  
}

// MARK: - Notification
private extension SecurityInputView {
  
  @objc func textFiledEditChanged(_ notification: Notification)  {
    
    guard (notification.object as? UITextField) == textField else { return }
    
    switch style {
    case .mobile:
    
      textField.text = checkMobile(filter(textField.text ?? "", regexString: "[^A-Za-z0-9]"))
      
    case .verify:
      
      textField.text = checkCode(filter(textField.text ?? "", regexString: "[^A-Za-z0-9]"))
    default:
      break
    }
  }
  
}

// MARK: - Utility
private extension SecurityInputView {
  
  func filter(_ text: String, regexString: String) -> String? {
    
    let regex = try? NSRegularExpression.init(pattern: regexString, options: NSRegularExpression.Options.caseInsensitive)
    let result = regex?.stringByReplacingMatches(in: text, options: .reportProgress, range: NSRange(location: 0, length: text.count), withTemplate: "")
    return result
    
  }
  
  func checkMobile(_ text: String?) -> String? {
    
    guard let string = text else { return text }
    if string.count > 11 {
    
      let endIndex = string.index(string.startIndex, offsetBy: 11)
      return String(string.prefix(upTo: endIndex))
    }
    
    return string
  }
  
  func checkCode(_ text: String?) -> String? {
    
    guard let string = text else { return text }
    if string.count > 6 {
    
      let endIndex = string.index(string.startIndex, offsetBy: 4)
      return String(string.prefix(upTo: endIndex))
    }
    
    return string
    
  }
  
}
