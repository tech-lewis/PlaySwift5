通用的Cell 用于显示文本

BadgeView: UIView
AgreementViewController.swift 通用的网页加载控制器
BottomContainerView.swift  包括安全区的屏幕底布视图
MultiTabPageViewController 的使用

ZCycleView的使用
```

  private let bannerView = ZCycleView(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
    bannerView.setUrlsGroup(["https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3892521478,1695688217&fm=26&gp=0.jpg", "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3892521478,1695688217&fm=26&gp=0.jpg"])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


// MARK: - ZCycleViewProtocol
extension HomeBannerView: ZCycleViewProtocol {
  
  func cycleViewDidScrollToIndex(_ index: Int) {
    
  }
  
  func cycleViewDidSelectedIndex(_ index: Int) {

  }
  
  func customCollectionViewCellClassForCycleScrollView() -> AnyClass {
    
    return CollectionSingleImageCell.self
    
  }
  
  func setupCustomCell(_ cell: UICollectionViewCell, for index: NSInteger, cycleView: ZCycleView) {
    
    guard let cell = cell as? CollectionSingleImageCell else { return }
    cell.setup(image: "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3892521478,1695688217&fm=26&gp=0.jpg")
  }

  返回写好的CollectionCell视图
```