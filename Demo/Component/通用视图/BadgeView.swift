//
//  BadgeView.swift
//  显示角标的View

import UIKit

class BadgeView: UIView {
  
  private var style: Style = .number {
    
    didSet {
      
      if style == .redDot {
        
        self.badgeText = "."
      }
    }
  }
  
  /// 背景颜色
  var badgeBackgroundColor: UIColor = .red {
    didSet { layer.backgroundColor = badgeBackgroundColor.cgColor }
  }
  /// 背景圆圈周边的宽度
  var badgeStrokeWidth: CGFloat = 0 {
    didSet { layer.borderWidth = badgeStrokeWidth }
  }
  /// 背景圆圈周边的颜色
  var badgeStrokeColor: UIColor = .white {
    didSet { layer.borderColor = badgeStrokeColor.cgColor }
  }
  /// 文本颜色
  var badgeTextColor: UIColor = .white {
    didSet { textButton.setTitleColor(badgeTextColor, for: .normal) }
  }
  /// 文本字体
  var badgeTextFont: UIFont = UIFont.systemFont(ofSize: 10) {
    didSet { textButton.titleLabel?.font = self.badgeTextFont }
  }
  /// 数字
  var badgeValue: Int = 0 {
    didSet {
      self.isHidden = (badgeValue < 1)
      self.badgeText = badgeValue > 99 ? "99+" : "\(badgeValue)"
    }
  }
  
  private var badgeText: String = "." {
    didSet { textButton.setTitle(badgeText, for: .normal) }
  }

  
  private let textButton = UIButton(type: .custom)
  
  init(_ style: Style) {
    super.init(frame: .zero)
    
    self.backgroundColor = .clear
    self.style = style
    
    layer.cornerRadius = 10
    layer.masksToBounds = true;
    layer.backgroundColor = badgeBackgroundColor.cgColor
    layer.borderColor = badgeStrokeColor.cgColor
    layer.borderWidth = badgeStrokeWidth
    
    textButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    textButton.isUserInteractionEnabled = false
    textButton.setTitleColor(badgeTextColor, for: .normal)
    textButton.titleLabel?.font = badgeTextFont
    textButton.setTitle(badgeText, for: .normal)
    addSubview(textButton)
    textButton.layout.add { (make) in
      make.top().bottom().leading().trailing().equal(self)
      make.height(20)
      make.width(20).greaterThanOrEqual(nil)
    }
    
  }
  
//  override func layoutSubviews() {
//
//    super.layoutSubviews()
//    /// 设置view大小
//    let textWidth = self.sizeOfTextForCurrentSettings().width
//    let viewWidth = textWidth + self.textSideMargin + self.marginToDrawInside * 2
//    let viewHeight = self.badgeViewHeight + self.marginToDrawInside * 2
//    let selfWidth = max(viewWidth, viewHeight)
//    self.bounds = CGRect(x: 0, y: 0, width:selfWidth, height: viewHeight)
//    self.setNeedsDisplay()
//  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension BadgeView {
  
  enum Style {
    case redDot
    case number
  }

}
