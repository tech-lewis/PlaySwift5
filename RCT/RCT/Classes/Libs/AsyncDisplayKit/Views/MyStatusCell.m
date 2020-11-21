//
//  MyStatusCell.m
//  RCT
//
//  Created by mac on 21.11.20.
//  Copyright © 2020 Mark. All rights reserved.
//

#import "MyStatusCell.h"
#import "ASTextNode.h"
#import "ASDisplayNode+Subclasses.h"
@interface MyStatusCell() {
  NSString *_text;
  ASTextNode *_textNode;
}

@end
@implementation MyStatusCell

static const CGFloat kHorizontalPadding = 15.0f;
static const CGFloat kVerticalPadding = 11.0f;
static const CGFloat kFontSize = 18.0f;

- (instancetype)init
{
  if (!(self = [super init]))
    return nil;

  _textNode = [[ASTextNode alloc] init];
  [self addSubnode:_textNode];

  return self;
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
  CGSize availableSize = CGSizeMake(constrainedSize.width - 2 * kHorizontalPadding,
                                    constrainedSize.height - 2 * kVerticalPadding);
  CGSize textNodeSize = [_textNode measure:availableSize];

  return CGSizeMake(ceilf(2 * kHorizontalPadding + textNodeSize.width),
                    ceilf(2 * kVerticalPadding + textNodeSize.height));
}

- (void)layout
{
  _textNode.frame = CGRectInset(self.bounds, kHorizontalPadding, kVerticalPadding);
}

- (void)setText:(NSString *)text
{
  if (_text == text)
    return;

  _text = [text copy];
  _textNode.attributedString = [[NSAttributedString alloc] initWithString:_text
                                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kFontSize], NSForegroundColorAttributeName: [UIColor orangeColor]}];

  [self invalidateCalculatedSize];
}
@end
