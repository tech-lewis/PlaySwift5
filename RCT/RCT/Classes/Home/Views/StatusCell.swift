//
//  StatusCell.swift
//  RCT
//
//  Created by Mark on 2020/9/24.
//  Copyright © 2020年 Mark. All rights reserved.
//  if (_text == text)

import UIKit

class StatusCell: ASCellNode {
    public var text: String {
        didSet {
            _textNode?.attributedString = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: kFontSize), NSAttributedStringKey.foregroundColor: UIColor.orange
              ])
            super.invalidateCalculatedSize()
        }
    }
    
    private var _textNode = ASTextNode()
    
    var kHorizontalPadding: CGFloat = 15.0
    var kVerticalPadding: CGFloat = 11.0
    var kFontSize: CGFloat = 18.0
    
    override init() {
        self.text = ""
        super.init()
        self.setupUI()
    }
    
    
}


extension StatusCell {
    func setupUI() {
        // 布局UI
        self.addSubnode(_textNode)
    }
    
    // layout
    override func layout() {
        _textNode?.frame = self.bounds.insetBy(dx: kHorizontalPadding, dy: kVerticalPadding)
        // 构造新的frame
    }
    func constrainedSizeForCalculatedSize(constrainedSize: CGSize) -> CGSize {
        let availableSize = CGSize(width: constrainedSize.width - 2*kHorizontalPadding, height: (constrainedSize.height - 2*kVerticalPadding));
        let textNodeSize = _textNode?.measure(availableSize)
        
        let calcW = 2 * kHorizontalPadding + (textNodeSize?.width ?? 0.0)
        let w = ceill(Double(calcW))
        let calcH = 2 * kVerticalPadding + (textNodeSize?.height ?? 0.0)
        let h = ceill(Double(calcH))
        return CGSize(width: w, height: h)
    }
}
