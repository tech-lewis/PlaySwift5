//
//  BottomContainerView.swift
//  ZhouXin
import UIKit
import ApplicationKit

class BottomContainerView: UIView {
  
  let contentView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Public
extension BottomContainerView {
  
}

// MARK: - Setup
private extension BottomContainerView {
  
  func setupUI() {
    
    addSubview(contentView)
    contentView.layout.add { (make) in
      make.top().leading().trailing().equal(self)
      make.bottom().equal(self).safeBottom()
    }
  }
  
}
