//
//  NSTimer+EZPlayer.swift
//  EZPlayer
//
//  Created by yangjun zhu on 2016/12/28.
//  Copyright © 2016年 yangjun zhu. All rights reserved.
//

import Foundation

extension Timer {
  
  class func scheduledTimerWithTimeInterval(_ timeInterval: TimeInterval, block: @escaping ()->(),  repeats: Bool) -> Timer{
    return self.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Timer.executeBlockWithTimer(_:)), userInfo: AnyObject.self, repeats: repeats)
  }
  
  class func timerWithTimeInterval(_ timeInterval: TimeInterval, block: @escaping ()->(),  repeats: Bool) -> Timer {
    
    return Timer(timeInterval: timeInterval, target: self, selector: #selector(Timer.executeBlockWithTimer(_:)), userInfo: block, repeats: repeats)
  }
  
  @objc private class func executeBlockWithTimer(_ timer: Timer){
    let block: ()->() = timer.userInfo as! ()->()
    block()
  }
  
  static func executeOnMainQueueAfterTimeInterval(_ seconds: TimeInterval,block: @escaping ()->()) {
    executeAfterTimeInterval(seconds, queue: DispatchQueue.main, block: block)
  }
  
  static func executeAfterTimeInterval(_ seconds: TimeInterval, queue: DispatchQueue, block: @escaping ()->()) {
    let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    queue.asyncAfter(deadline: time, execute: block)
  }
}
