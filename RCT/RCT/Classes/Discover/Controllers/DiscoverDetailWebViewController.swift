//
//  DiscoverDetailWebViewController.swift
//  RCT
//
//  Created by mac on 21.11.20.
//  Copyright © 2020 Mark. All rights reserved.
//
import UIKit

class DiscoverDetailWebViewController: UIViewController {
    private var webView = UIWebView()
    private let spinner = UIActivityIndicatorView()
    /// Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        
    }
}

// MARK: - Public
extension DiscoverDetailWebViewController {
    
}

// MARK: - Setup
private extension DiscoverDetailWebViewController {
    
    func setupUI() {
        self.title = "Web Content"
        view.addSubview(webView)
        self.webView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        view.addSubview(spinner)
        spinner.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        spinner.center = view.center
        spinner.hidesWhenStopped = true
//        self.spinner.mas_makeConstraints { (make) in
//            make?.centerX.centerX()?.equalTo()(self.view)
//            make?.height.equalTo()(30.0)
//            make?.width.equalTo()(30.0)
//        }
        
        if #available(iOS 13.0, *) {
            self.spinner.activityIndicatorViewStyle = .large
        } else {
            self.spinner.activityIndicatorViewStyle = .gray
        }
        
        webView.delegate = self
    }
    
    func updateUI() {
        // 不要强制解包
        guard let url = URL(string: "https://en.jinzhao.wiki/wiki/Xcode") else {return}
        let requst = URLRequest(url: url)
        webView.loadRequest(requst)
        // spinner start
        spinner.startAnimating()
    }
}


extension DiscoverDetailWebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
        print("finshed")
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        spinner.stopAnimating()
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
        //print("webViewDidStartLoad!")
        //self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
    }
    
}
