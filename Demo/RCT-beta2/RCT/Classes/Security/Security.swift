//
//  Security.swift
//  OnlineTutor
//
//  Created by feijin on 2020/10/27.
//

import UIKit
import ApplicationKit
import ComponentKit

class Security: NSObject {
  
  static let loginNotification = Notification.Name("LoginNotification")
  
  static let logoutNotification = Notification.Name("LogoutNotification")
  
  static let userInfoDidUpdatedNotification = Notification.Name("UserInfoDidUpdatedNotification")
  
  
  private static let shared = Security()
  
  private var isLogin: Bool = false
  
  private override init() {
    super.init()
    
    NotificationCenter.default.addObserver(self, selector: #selector(recieveLogin(_:)), name: Security.loginNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(recieveLogout(_:)), name: Security.logoutNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(receiveLoginTimeOut(_:)), name: API.loginTimeoutNotification, object: nil)
  }
  
  deinit {
    
    NotificationCenter.default.removeObserver(self)
  }
}


// MARK: - Public
extension Security {
  
  static var isLogin: Bool { return Security.shared.isLogin }
  
  static func checkLogin() -> Bool {
    
    guard Security.shared.isLogin else {
      
      
      let viewController = LoginViewController()
      let nav = UINavigationController(rootViewController: viewController)
      nav.modalPresentationStyle = .fullScreen
      Presenter.present(nav)
      
      return false
    }
    return true
  }
  
  static func showLogin() {
    
    let viewController = LoginViewController()
    let nav = UINavigationController(rootViewController: viewController)
    nav.modalPresentationStyle = .fullScreen
    Presenter.present(nav)
    
  }
  
  static func prepare() {

    guard Security.shared.isLogin == false else { return }

    API.token = UserDefaults.standard.string(forKey: Key.token.rawValue)
    
    Security.shared.isLogin = API.token != nil
    
    Security.shared.isLogin = true

//    API.userInfo.request(handle: { (result) in
//
//      guard result["result"] == 1 else {
//        return
//      }
//      var info = UserInfoItem(result["data"])
//      guard let _ = info.id else { return }
//      Security.shared.isLogin = true
    
//    })
    
  }
  
  
}

// MARK: - Utility
private extension Security {
  
  
  enum Key: String {
    
    case token = "Token"
  }
  
}

// MARK: - Notification
private extension Security {
  
  @objc func recieveLogin(_ notification: Notification) {
    
    Security.shared.isLogin = true
    UserDefaults.standard.set(API.token, forKey: Key.token.rawValue)
    
    Presenter.dismiss()
    
  }
  
  @objc func recieveLogout(_ notification: Notification) {
    
    Security.shared.isLogin = false
    API.token = nil
    UserDefaults.standard.set(nil, forKey: Key.token.rawValue)
    
    UIApplication.shared.keyWindow?.rootViewController = MainTabBarController()
    
  }
  
  @objc func receiveLoginTimeOut(_ notification: Notification) {
    
    Security.shared.isLogin = false
    API.token = nil
    UserDefaults.standard.set(nil, forKey: Key.token.rawValue)
    UIApplication.shared.keyWindow?.rootViewController = MainTabBarController()
    
    
  }
  
}
