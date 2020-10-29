//
//  ShareCollectionView.swift
//  CanQiTong 分享组件

import UIKit
import ApplicationKit

public class ShareCollectionView: UIView {
  
//  public var dataItem: ShareDataItem?
  public var maxVisibleCount: CGFloat = 3
  public var viewItems: [ShareCollectionCellItem] = [] {
    didSet { updateUI() }
  }
  
  private var customCell = ReuseItem(ShareCollectionCell.self)
  private let server = CollectionServer()
  private let alignmentLayout = UICollectionViewFlowLayout()//AlignmentLayout(style: .horizontalCenter)
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: alignmentLayout)
  
  
  init(frame: CGRect = .zero, cell: ReuseItem = ReuseItem(ShareCollectionCell.self)) {
    super.init(frame: frame)
    
    customCell = cell
    setupUI()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    
    alignmentLayout.itemSize = CGSize(width: bounds.width / maxVisibleCount, height: bounds.height)
    collectionView.layout.update { (make) in

      make.width(alignmentLayout.itemSize.width * CGFloat(viewItems.count))
    }
  }
  
}

// MARK: - Public
public extension ShareCollectionView {
  
  func setupDefaultViewData() {
//
//    if OpenManager.isInstallWeChat()  {
//
//      viewItems.append(ShareCollectionCellItem(image: "icon_wx", title: "微信", shareType: .wechatSession))
//
//    }
//    viewItems.append(ShareCollectionCellItem(image: "icon_qq", title: "QQ", shareType: .qqFriends))
//    viewItems.append(ShareCollectionCellItem(image: "icon_weibo", title: "微博", shareType: .sinaWeibo))
  }
  
}

// MARK: - Setup
private extension ShareCollectionView {
  
  func setupUI() {
    
    backgroundColor = .white
    server.setup(collectionView)
    
    alignmentLayout.scrollDirection = .horizontal
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    addSubview(collectionView)
    collectionView.layout.add { (make) in
  
      make.top().bottom().centerX().equal(self)
      make.width(alignmentLayout.itemSize.width * CGFloat(viewItems.count))
    }
  }
  
  func updateUI() {
    
    var group = CollectionSectionGroup()
    viewItems.forEach({ (item) in
      
      group.items.append(CollectionCellItem(customCell, data: item, selected: { [weak self] in
//        self?.share(item.shareType)
        Presenter.dismiss()
      }))
    })
    server.update([group])
  }
  
}

// MARK: - Action
private extension ShareCollectionView {
  
//  func share(_ type: OpenShareItem.ShareType) {
//    
//    guard let item = dataItem?.openShareItem else { return }
//    OpenManager.share(with: item, for: type) { (isSuccess, message) in
//      
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//        
//        Presenter.currentPresentedController?.hud.showMessage(message: message)
//      })
//    }
//  }
}
