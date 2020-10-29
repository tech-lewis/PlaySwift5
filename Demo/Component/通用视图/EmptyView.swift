//
//  EmptyView.swift
//  ImageKnight
//  缺省的背景图 包括StackView的用法
import UIKit
import ApplicationKit

class EmptyView: UIView {
  
  var offsetY: CGFloat = 0.0 {
    didSet {
      stackView.layout.update { (make) in
        make.centerY(offsetY).equal(self)
      }
    }
  }
  
  var isShowRefresh: Bool = false {
    didSet {
      if isShowRefresh {
        stackView.addArrangedSubview(refreshButton)
      }else {
        stackView.removeArrangedSubview(refreshButton)
      }
      
    }
  }
  
  let stackView = UIStackView()
  let imageView = UIImageView()
  let textLabel = UILabel()
  let refreshButton = UIButton(type: .custom)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 20
    addSubview(stackView)
    stackView.layout.add { (make) in
      make.centerX().centerY().equal(self)
    }
    
    imageView.image = UIImage(named: "placeholder_empty")
    stackView.addArrangedSubview(imageView)

    
    textLabel.text = "暂无内容~"
    textLabel.textAlignment = .center
    textLabel.numberOfLines = 0
    textLabel.font = Font.pingFangSCMedium(13)
    textLabel.textColor = UIColor(0xc1c1c1)
    stackView.addArrangedSubview(textLabel)
    
    refreshButton.setTitle("刷新", for: .normal)
    refreshButton.setTitleColor(Color.textOfMedium, for: .normal)
    refreshButton.titleLabel?.font = Font.pingFangSCRegular(14)
    refreshButton.layer.cornerRadius = 3
    refreshButton.layer.borderColor = Color.textOfMedium.cgColor
    refreshButton.layer.borderWidth = 1
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension EmptyView {
  
  static func failedView() -> EmptyView {
    
    let view = EmptyView()
    view.isShowRefresh = true
    view.imageView.image = UIImage(named: "placeholder_empty_loadFail")
    view.textLabel.text = "网络不给力\n请检查网络设置或稍后重拾试"
    view.backgroundColor = .white
    return view
    
  }
  
  static func create(withTitle title: String = "暂无内容", imageName: String = "placeholder_empty", isShowRefresh: Bool = false) -> EmptyView {
    
    let view = EmptyView()
    view.isShowRefresh = isShowRefresh
    view.imageView.image = UIImage(named: imageName)
    view.textLabel.text = title
    return view
    
  }
  
}
