//
//  AgreementViewController.swift
//  通用的协议加载控制器

import UIKit
import ApplicationKit
import WebKit

class AgreementViewController: UIViewController {
  
  enum AgreementType: Int {
    /// 用户协议
    case user = 14
    /// 隐私协议
    case privacy = 5
    /// 知识产权
    case intellectualProperty = 1
    /// 课程
    case course = 2
    /// 关于我们
    case aboutUs = 3
    /// 免责声明
    case disclaimer = 4
    /// 侵权投诉
    case infringement = 6
    /// 联系我们
    case contactUs = 7
    /// 法律责任
    case legalLiability = 8
    /// 帮助中心
    case helper = 9
    /// 服务协议
    case serviceAgreement = 10
    /// 视频常见问题
    case videoProblem = 11
    /// 课程常见问题
    case courseProblem = 12
    /// 直播常见问题
    case liveProblem = 13
  }
  
  var type: AgreementType = .user
  var htmlString: String? { didSet { self.loadHtmlData() } }
  private var webView = WKWebView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    loadContent()
  }
  
}

// MARK: - Public
extension AgreementViewController {
  
}

// MARK: - Setup
private extension AgreementViewController {
  
  func setupUI() {
    
    switch type {
    case .user:
      navigationView.setup(title: "用户协议")
    case .privacy:
      navigationView.setup(title: "隐私协议")
    case .intellectualProperty:
      navigationView.setup(title: "知识产权")
    case .course:
      navigationView.setup(title: "课程")
    case .aboutUs:
      navigationView.setup(title: "关于我们")
    case .disclaimer:
      navigationView.setup(title: "免责声明")
    case .infringement:
      navigationView.setup(title: "侵权投诉")
    case .contactUs:
      navigationView.setup(title: "联系我们")
    case .legalLiability:
      navigationView.setup(title: "法律责任")
    case .helper:
      navigationView.setup(title: "帮助中心")
    case .serviceAgreement:
      navigationView.setup(title: "服务协议")
    case .videoProblem:
      navigationView.setup(title: "视频常见问题")
    case .courseProblem:
      navigationView.setup(title: "课程常见问题")
    case .liveProblem:
      navigationView.setup(title: "直播常见问题")
    }
    navigationView.showBack()
    
    view.backgroundColor = .white
    
    if #available(iOS 11.0, *) {
      self.webView.scrollView.contentInsetAdjustmentBehavior = .never
    } else {
      self.automaticallyAdjustsScrollViewInsets = false
    }
    
    let wkUController = WKUserContentController()
    let wkWebConfig = WKWebViewConfiguration()
    wkWebConfig.userContentController = wkUController
    
    self.webView = WKWebView(frame: .zero, configuration: wkWebConfig)
    self.webView.uiDelegate = self
    self.webView.navigationDelegate = self
    self.webView.scrollView.showsVerticalScrollIndicator = false
    self.view.addSubview(self.webView)
    self.webView.layout.add { (make) in
      
      make.top(10).equal(navigationView).bottom()
      make.leading(15).trailing(-15).bottom().equal(self.view)
      make.bottom().equal(self.view).bottom()
    }
    
  }
  
  func updateUI() {
    
  }
  
}

// MARK: - Action
private extension AgreementViewController {
 
  
  
}

// MARK: - Utiltiy
private extension AgreementViewController {
  
  func loadContent() {
    
    var parameters = API.parameters
    parameters["id"] = type.rawValue
    API.agreement.query(parameters).request(handle: { (result) in
      
      guard result["result"] == 1 else {
        Presenter.showMessage(message: result["msg"])
        return
      }
      self.htmlString = result["data"]["content"]
      self.navigationView.setup(title: result["data"]["title"])
      
    })
  }
  
  func loadHtmlData() {
    
    guard let htmlString = self.htmlString else { return }
    
    let header = "<head>" + "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"> " + "<style>img{width: 100%; height:auto;}*{margin:0;padding:0;boder:0}</style>" + "</head>"
    
    let html = "<html>" + "\(header)" + "<body>" + "\(htmlString)" + "</body></html>"
    
    self.webView.loadHTMLString(html, baseURL: nil)
  }
  
}

// MARK: - WKUIDelegate
extension AgreementViewController: WKUIDelegate {
  
}

// MARK: - WKNavigationDelegate
extension AgreementViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
    self.hud.showLoading()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
    self.hud.hideLoading()
    
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    
    self.hud.showMessage(message: "服务器出小差，请稍后重试")
  }
}
