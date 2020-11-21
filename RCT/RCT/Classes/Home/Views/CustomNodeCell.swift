//
//  CustomNodeCell.swift
//  RCT
//
//  Created by mac on 15.11.20.
//  Copyright © 2020 Mark. All rights reserved.
//
import UIKit
class CustomCellNode: ASCellNode {
    
    let iconImageView = UIImageView()
    let titleLabel = ASTextNode()
    let subTitleLabel = ASTextNode()
    
    override init!() {
        super.init()
        //addSubnode(iconImageView)
        addSubnode(titleLabel)
        addSubnode(subTitleLabel)
    }
    
    func configureData(iconURL: NSURL, title: String, subTitle: String) {
//        iconImageView.URL = iconURL
//        titleLabel.attributedString = NSAttributedString(string: title, attributes: [
//            NSForegroundColorAttributeName: UIColor.blackColor(),
//            NSFontAttributeName: UIFont.systemFontOfSize(17)
//            ])
//        subTitleLabel.attributedString = NSAttributedString(string: subTitle, attributes: [
//            NSForegroundColorAttributeName: UIColor.grayColor(),
//            NSFontAttributeName: UIFont.systemFontOfSize(15)
//            ])
    }
    
//    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
//        // 这是一堆约束，只是给开发者看的。
//        // |-15-[iconImageView(60)]-15-[titleLabel]-15-|
//        // |-15-[iconImageView(60)]-15-[subTitleLabel]-15-|
//        // V:|-8-[titleLable]-3-[subTitleLabel]-8-|
//        // V:|-2-[iconImageView(60)]-2-|
//        let textMaxWidth = constrainedSize.width - 15 - 60 - 15 - 15
//        titleLabel.measure(CGSize(width: textMaxWidth, height: CGFloat.max))
//        subTitleLabel.measure(CGSize(width: textMaxWidth, height: CGFloat.max))
//        if 8 + titleLabel.calculatedSize.height + subTitleLabel.calculatedSize.height + 8 < 64.0 {
//            return CGSize(width: constrainedSize.width, height: 64.0)
//        }
//        else {
//            return CGSize(width: constrainedSize.width,
//                height: 8 + titleLabel.calculatedSize.height + subTitleLabel.calculatedSize.height + 8)
//        }
//    }
//
//    override func layout() {
//        // 开始布局吧，如果你看到这里已经心碎了？
//        iconImageView.frame = CGRect(x: 15, y: 2, width: 60, height: 60)
//        titleLabel.frame = CGRect(x: 15 + 60 + 15, y: 8, width: titleLabel.calculatedSize.width, height: titleLabel.calculatedSize.height)
//        subTitleLabel.frame = CGRect(x: 15 + 60 + 15, y: titleLabel.frame.origin.y + titleLabel.frame.size.height, width: subTitleLabel.calculatedSize.width, height: subTitleLabel.calculatedSize.height)
//    }
}
