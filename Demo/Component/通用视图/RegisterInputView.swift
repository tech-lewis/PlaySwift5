//
//  RegisterInputView.swift
//  通用的左右布局类Cell单元格的View 包括发送验证码样式

import UIKit
import ApplicationKit

protocol RegisterInputViewDelegate: class {
  
  /// 点击发送验证码事件
  ///
  /// - Parameters:
  ///   - view: RegisterInputView
  ///   - handle: 发送验证码是否成功
  func registerInputView(_ view: RegisterInputView, sendVerifyCodeResult handle: @escaping (_ isSuccess: Bool) -> Void)
  
}

class RegisterInputView: UIView {
  
  weak var delegate: RegisterInputViewDelegate?
  
  var placeholder: String? {
    set { update(placeholder: newValue) }
    get { return textField.placeholder }
  }
  
  var content: String? { return textField.text }
  
  var style: Style = .none { didSet { updateAppearance() } }
  
  private let textField = UITextField()
  private let bottomLineView = UIView()
  private let leftButton = UIButton(type: .custom)
  private let rightButton = UIButton(type: .custom)
  private let verticalLine = UIView()
  
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
extension RegisterInputView {
  
  enum Style {
    
    case none
    
    case mobile
    case password
    case originalPassword
    case newPassword
    case registerPassword
    case verify
    
  }
  
  func clear() {
    
    textField.text = nil
  }
  
}

// MARK: - Setup
private extension RegisterInputView {
  
  func setupUI() {
    
    //layer.borderColor = UIColor.white.cgColor
    //layer.borderWidth = 0.5
    
    leftButton.frame.size = CGSize(width: 70, height: 40)
    leftButton.contentHorizontalAlignment = .left
    leftButton.isUserInteractionEnabled = false
    leftButton.setTitleColor(Color.textOfDeep, for: .normal)
    leftButton.titleLabel?.font = Font.pingFangSCMedium(14)
    leftButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    leftButton.layout.add { (make) in
      make.width(80).height(40)
    }
    textField.leftView = leftButton
    
    rightButton.addTarget(self, action: #selector(clickRight), for: .touchUpInside)
    textField.rightView = rightButton
    
//    textField.tintColor = Color.textOfDeep
    textField.textColor = Color.textOfDeep
    textField.font = Font.pingFangSCMedium(14)
    textField.clearButtonMode = .whileEditing
    textField.addTarget(self, action: #selector(beginEdit), for: .editingDidBegin)
    textField.addTarget(self, action: #selector(endEdit), for: .editingDidEnd)
    textField.showKeyboardToolBar()
    textField.keyboardType = .numberPad
    
    addSubview(textField)
    textField.layout.add { (make) in
      make.top().bottom().leading(15).trailing(-15).equal(self)
    }
    
    //bottomLineView.backgroundColor = Color.textOfBlue
    bottomLineView.backgroundColor = Color.grayBackground
    addSubview(bottomLineView)
    bottomLineView.layout.add { (make) in
      make.leading(15).trailing(-15).bottom().equal(self)
      make.height(1)
    }
  }
  
}

// MARK: - Action
private extension RegisterInputView {
  
  @objc func beginEdit(_ textField: UITextField) {
    
    //bottomLineView.backgroundColor = Color.blue
    leftButton.isSelected = textField.isFirstResponder
  }
  
  @objc func endEdit(_ textField: UITextField) {
    
    //bottomLineView.backgroundColor = Color.blue
    //bottomLineView.backgroundColor = Color.line
    leftButton.isSelected = textField.isFirstResponder
  }
  
  @objc func clickRight(_ sender: UIButton) {
    
    switch style {
    case .verify:
      
      sender.isUserInteractionEnabled = false
      delegate?.registerInputView(self, sendVerifyCodeResult: { [weak self] (isSuccess) in
        
        sender.isUserInteractionEnabled = true
        if isSuccess == false { return }
        
        sender.isEnabled = false
        sender.layer.borderColor = Color.textOfSilver.cgColor
        self?.timer.start(withDeadline: Date(timeInterval: 61, since: Date()), update: { (date) in
          
          guard let minute = date.minute else { return }
          guard let second = date.second else { return }
          sender.setTitle("\(minute * 60 + second)S", for: .disabled)
          
        }, timeEnd: {
          
          sender.isEnabled = true
          sender.layer.borderColor = Color.textOfMedium.cgColor
          sender.setTitle("发送验证码", for: .disabled)
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
private extension RegisterInputView {
  
  func updateAppearance() {
    
    switch style {
    case .mobile:
      
      leftButton.setTitle("手机号码", for: .normal)
      textField.placeholder = "请输入手机号码"
      textField.leftViewMode = .always
      textField.keyboardType = .numberPad
      textField.isSecureTextEntry = false
      
    case .password:

      leftButton.setTitle("密码", for: .normal)
      textField.placeholder = "请输入登录密码"
      textField.leftViewMode = .always
      textField.keyboardType = .default
      setupPasswordSecurityModeButton()
      textField.isSecureTextEntry = true
    
    case .registerPassword:
    
      leftButton.setTitle("登录密码", for: .normal)
      textField.placeholder = "请设置登录密码"
      textField.leftViewMode = .always
      textField.keyboardType = .default
      setupPasswordSecurityModeButton()
      textField.isSecureTextEntry = true
    
    case .originalPassword:
      
      leftButton.setTitle("原密码", for: .normal)
      textField.placeholder = "请输入原密码"
      textField.leftViewMode = .always
      textField.keyboardType = .default
      setupPasswordSecurityModeButton()
      textField.isSecureTextEntry = true
      
    case .newPassword:
      
      leftButton.setTitle("新密码", for: .normal)
      textField.placeholder = "请输入新密码"
      textField.leftViewMode = .always
      textField.keyboardType = .default
      setupPasswordSecurityModeButton()
      textField.isSecureTextEntry = true
      
    case .verify:
      
      leftButton.setTitle("验证码", for: .normal)
      textField.placeholder = "请输入验证码"
      textField.leftViewMode = .always
      textField.keyboardType = .numberPad
      setupSendVerifyCodeButton()
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
    
    rightButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
    rightButton.setImage(UIImage(named: "security_password_visible"), for: .normal)
    rightButton.setImage(UIImage(named: "security_password_invisible"), for: .selected)
    rightButton.isSelected = true
    rightButton.layout.add { (make) in
      make.width(44).height(44)
    }
    
    textField.rightView = rightButton
    textField.rightViewMode = .always
  }
  
  func setupSendVerifyCodeButton() {
    
    rightButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
    rightButton.titleLabel?.font = Font.pingFangSCMedium(12)
    rightButton.setTitleColor(Color.textOfMedium, for: .normal)
    rightButton.setTitleColor(Color.textOfSilver, for: .disabled)
    rightButton.setTitle("发送验证码", for: .normal)
    rightButton.layer.borderColor = Color.textOfMedium.cgColor
    rightButton.layer.borderWidth = 1
    rightButton.layer.cornerRadius = 3
    rightButton.addTarget(self, action: #selector(clickRight(_:)), for: .touchUpInside)
    rightButton.layout.add { (make) in
      make.width(80).height(30)
    }
    
    textField.rightView = rightButton
    textField.rightViewMode = .always
  }
  
}

// MARK: - Notification
private extension RegisterInputView {
  
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
private extension RegisterInputView {
  
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
