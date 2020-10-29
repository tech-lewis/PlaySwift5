//
//  ShareViewController.swift
//  分享组件控制器

import UIKit
import ApplicationKit
import ComponentKit

class ShareViewController: UIViewController {
  
//  private var dataItem: ShareDataItem?
  private let hideButton = UIButton(type: .custom)
  private let contentView = GradientView()
  private let bottomContainer = BottomContainerView()
  private let cancelButton = UIButton(type: .custom)
  private let layout = UICollectionViewFlowLayout()
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
  private let server = CollectionServer()
  
  private var items: [ShareCollectionCellItem] = []
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
     
     let delegate = Transitioning()
     transitioningDelegate = delegate
     modalPresentationStyle = .custom

   }
   
   required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
   }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    updateUI()
  }
  
}

// MARK: - Public
extension ShareViewController {
  
  static func share(withItems items: [ShareCollectionCellItem]) {
    
    let controller = ShareViewController()
    controller.items = items
    let presentationController = SharePresentationController(presentedViewController: controller, presenting: Presenter.currentPresentedController)
    controller.transitioningDelegate = presentationController
    Presenter.present(controller, animated: true)
  }
  
}

// MARK: - Setup
private extension ShareViewController {
  
  func setupUI() {
    
    navigationView.isHidden = true
    view.backgroundColor = .clear

    contentView.backgroundColor = UIColor(0xF2F2F2)
    contentView.corners = [.topLeft, .topRight]
    contentView.cornerSize = CGSize(width: 5, height: 5)
    contentView.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
    view.addSubview(contentView)
    contentView.layout.add { (make) in
      make.leading().trailing().bottom().equal(view)
      make.bottom().equal(view).safeBottom()
    }
    
    let fullWidth = App.shared.screen.width
    let imageWidth: CGFloat = 45
    let space = (fullWidth - imageWidth * 5) / 6
    
    layout.itemSize = CGSize(width: imageWidth + space, height: 66)
    layout.sectionInset = UIEdgeInsets(top: 17.5, left: space / 2, bottom: 17.5, right: space / 2)
    
    let row = CGFloat((items.count + 4) / 5)
    
    
    server.setup(collectionView)
    collectionView.backgroundColor = .clear
    contentView.addSubview(collectionView)
    collectionView.layout.add { (make) in
      make.leading().top().trailing().equal(contentView)
      make.height(17.5 * 2 + row * (66 + 15) - 15)
    }
    
    bottomContainer.backgroundColor = .white
    contentView.addSubview(bottomContainer)
    bottomContainer.layout.add { (make) in
      make.top().equal(collectionView).bottom()
      make.leading().trailing().equal(contentView)
      make.bottom().equal(contentView).safeBottom()
    }
    
    cancelButton.setTitle("取消", for: .normal)
    cancelButton.setTitleColor(Color.textOfDeep, for: .normal)
    cancelButton.titleLabel?.font = Font.pingFangSCMedium(15)
    cancelButton.addTarget(self, action: #selector(clickHide), for: .touchUpInside)
    bottomContainer.contentView.addSubview(cancelButton)
    cancelButton.layout.add { (make) in
      make.leading().top().trailing().bottom().equal(bottomContainer.contentView)
      make.height(50)
    }
    
    hideButton.setTitle(nil, for: .normal)
    hideButton.backgroundColor = .clear
    hideButton.addTarget(self, action: #selector(clickHide), for: .touchUpInside)
    view.addSubview(hideButton)
    hideButton.layout.add { (make) in
      make.leading().top().trailing().equal(view)
      make.bottom().equal(contentView).top()
    }
    
  }
  
  func updateUI() {
    
    let cell = ReuseItem(ShareCollectionCell.self)
    
    var group = CollectionSectionGroup()
    group.lineSpacing = 15
    items.forEach { (item) in
      group.items.append(CollectionCellItem(cell, data: item, selected: {
        
        switch item.shareType {
        case .custom:
          Presenter.dismiss(animated: false) {
            item.customHandle?()
          }
        default: break
        }
        
      }))
    }
    
    server.update([group])
    
  }
  
}

// MARK: - Action
private extension ShareViewController {
  
  @objc func clickHide() {
    
    Presenter.dismiss()
  }
  
//  @objc func clickWechatSession() {
//
//    guard let item = dataItem?.openShareItem else { return }
//    share(type: .wechatSession, content: item)
//
//  }
//
//  @objc func clickWechatTimeline() {
//
//    guard let item = dataItem?.openShareItem else { return }
//    share(type: .wechatTimeline, content: item)
//
//  }
  
//  func share(type: OpenShareItem.ShareType, content: OpenShareItem) {
//
//    OpenManager.share(with: content, for: type) { (isSuccess, message) in
//
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//
//        Presenter.currentPresentedController?.hud.showMessage(message: message)
//      })
//    }
//  }
  
}

// MARK: - Utiltiy
private extension ShareViewController {
  
}
