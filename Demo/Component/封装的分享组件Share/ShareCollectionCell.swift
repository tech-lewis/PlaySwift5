//
//  ShareCollectionCell.swift
//  CanQiTong 分享组件
//

import UIKit
import ApplicationKit

class ShareCollectionCell: UICollectionViewCell {
  
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - CollectionCellItemUpdatable
extension ShareCollectionCell: CollectionCellItemUpdatable {
  
  func update(with item: CollectionCellItem) {
    
    guard let item = item.data as? ShareCollectionCellItem else { return }
    self.imageView.image = UIImage(named: item.image)
    self.titleLabel.text = item.title
  }
  
}

// MARK: - Setup
private extension ShareCollectionCell {
  
  func setupUI() {
    
    self.contentView.backgroundColor = .clear
    
    let containerView = UIView()
    containerView.backgroundColor = .clear
    contentView.addSubview(containerView)
    containerView.layout.add { (make) in
      make.top().bottom().centerY().equal(self.contentView)
    }
    
    containerView.addSubview(self.imageView)
    self.imageView.layout.add { (make) in
      make.leading().top().trailing().equal(containerView)
    }
    
    self.titleLabel.font = Font.pingFangSCMedium(11)
    self.titleLabel.textColor = Color.textOfMedium
    self.titleLabel.textAlignment = .center
    containerView.addSubview(self.titleLabel)
    self.titleLabel.layout.add { (make) in
      make.leading().trailing().bottom().equal(containerView)
//      make.top(8).equal(self.imageView).bottom()
    }
    
    
  }
  
}
