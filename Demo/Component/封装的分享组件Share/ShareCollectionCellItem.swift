//
//  ShareCollectionCellItem.swift
//  CanQiTong 分享组件

import Foundation

public struct ShareCollectionCellItem {

  public enum ShareType {
    /// 自定义
    case custom(icon: String, title: String)
    /// 微博
    case sinaWeibo
    /// 朋友圈
    case wechatTimeline
    /// 微信好友
    case wechatSession
    /// qq好友
    case qqFriends
    /// qq空间
    case qqZone
  }
  
  public let image: String
  public let title: String
  
  public let shareType: ShareType
  public let customHandle: (()->Void)?
  
  public init(type: ShareType, customHandle: (()->Void)? = nil) {
    
    self.shareType = type
    self.customHandle = customHandle
    
    switch type {
    case .custom(let icon,let title):
      self.image = icon
      self.title = title
    case .sinaWeibo:
      self.image = "share_weibo"
      self.title = "新浪微博"
    case .wechatTimeline:
      self.image = "share_wechatTimeline"
      self.title = "朋友圈"
    case .wechatSession:
      self.image = "share_wechatSession"
      self.title = "微信好友"
    case .qqFriends:
      self.image = "share_qqFriend"
      self.title = "QQ好友"
    case .qqZone:
      self.image = "share_qqZone"
      self.title = "QQ空间"
    }
    
    
  }
  
}
