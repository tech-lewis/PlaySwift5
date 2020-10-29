//
//  SharePresentationController.swift
//  ZengChengCityMuseum
//  分享组件

import UIKit

public class SharePresentationController: UIPresentationController  {
  
  private lazy var blackView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    if let frame = self.containerView?.bounds {
      view.frame = frame
    }
    return view
  }()
  
  override public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    
    presentedViewController.modalPresentationStyle = .custom
  }
  
  override public func presentationTransitionWillBegin() {
    super.presentationTransitionWillBegin()
    
    self.containerView?.addSubview(self.blackView)
    
    let transitionCoordinator: UIViewControllerTransitionCoordinator? = self.presentingViewController.transitionCoordinator
    
    self.blackView.alpha = 0
    
    transitionCoordinator?.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
      
      self.blackView.alpha = 0.4
    })
  }
  
  override public func dismissalTransitionWillBegin() {
    super.dismissalTransitionWillBegin()
    
    let transitionCoordinator: UIViewControllerTransitionCoordinator? = self.presentingViewController.transitionCoordinator;
    transitionCoordinator?.animate(alongsideTransition: { (context) in
      
      self.blackView.alpha = 0
    })
  }
  
  
  override public func presentationTransitionDidEnd(_ completed: Bool) {
    super.presentationTransitionDidEnd(completed)
    
    if !completed { self.blackView.removeFromSuperview() }
  }
  
  override public func dismissalTransitionDidEnd(_ completed: Bool) {
    super.dismissalTransitionDidEnd(completed)
    
    if completed { self.blackView.removeFromSuperview() }
  }
  
  override public var frameOfPresentedViewInContainerView: CGRect {
    
    guard let containerViewBounds: CGRect = self.containerView?.bounds else { return UIScreen.main.bounds }
    
    let presentedViewContentSize: CGSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)
    var presentedViewControllerFrame: CGRect = containerViewBounds
    presentedViewControllerFrame.size.height = presentedViewContentSize.height
    presentedViewControllerFrame.origin.y = containerViewBounds.maxY - presentedViewContentSize.height
    return presentedViewControllerFrame
  }
  
  override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
    super.preferredContentSizeDidChange(forChildContentContainer: container)
    
    if container.isEqual(self.presentedViewController) { self.containerView?.setNeedsLayout() }
  }
  
  override public func containerViewWillLayoutSubviews() {
    super.containerViewWillLayoutSubviews()
    
    if let frame: CGRect = self.containerView?.bounds { self.blackView.frame = frame }
    
  }
  
}

// MARK: - UIViewControllerTransitioningDelegate
extension SharePresentationController: UIViewControllerTransitioningDelegate {
  
  public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return self
  }
}
