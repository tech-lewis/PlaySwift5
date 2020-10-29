//
//  CollectionSingleImageCell.swift
//  ImageKnight轮播图
import UIKit
import ApplicationKit
import ImageKit

class CollectionSingleImageCell: UICollectionViewCell {
  
  struct DataModel {
    
    var image: Any?
    
    var placeholder = Placeholder.rectangle.name
    
    var cornerRadius: CGFloat = 0
    
    init(image: Any?, placeholder: String = Placeholder.rectangle.name, cornerRadius: CGFloat = 0) {
      self.image = image
      self.placeholder = placeholder
      self.cornerRadius = cornerRadius
    }
    
  }
  
  private let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - CollectionCellItemUpdatable
extension CollectionSingleImageCell: CollectionCellItemUpdatable {
  
  func update(with item: CollectionCellItem) {
    
    guard let data = item.data as? DataModel else { return }
    
    imageView.setImage(with: data.image, placeholder: data.placeholder)
    imageView.layer.cornerRadius = data.cornerRadius
    
  }
  
}

extension CollectionSingleImageCell {
  
  func setup(image: Any?) {
    
    imageView.setImage(with: image, placeholder: Placeholder.rectangle.name)
    
  }
  
}

// MARK: - Setup
private extension CollectionSingleImageCell {
  
  func setupUI() {
    
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    contentView.addSubview(imageView)
    imageView.layout.add { (make) in
      make.leading().top().trailing().bottom().equal(contentView)
    }
    
  }
  
}

// MARK: - Action
private extension CollectionSingleImageCell {
  
}
