//
//  UIButton+Extension.swift
//  SwiftMRK
//
//  Created by Mark on 2020/3/23.
//  Copyright © 2020年 markmarklewis. All rights reserved.
//

import Foundation

import UIKit

extension UIButton
{
    /*
     如果构造方法前面没有convenience单词, 代表着是一个初始化构造方法(指定构造方法)
     如果构造方法前面有convenience单词, 代表着是一个便利构造方法
     指定构造方法和便利构造方法的区别
     指定构造方法中必须对所有的属性进行初始化
     便利构造方法中不用对所有的属性进行初始, "因为便利构造方法依赖于指定构造方法"
     一般情况下如果想给系统的类提供一个快速创建的方法, 就自定义一个便利构造方法
     */
    convenience init(imageName: String, backgroundImageName: String)
    {
        
        self.init()
        
        // 2.设置前景图片
        setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        // 3.设置背景图片
        setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        
        // 4.调整按钮尺寸
        sizeToFit()
    }
}
