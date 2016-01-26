//
//  UIView+Size.m
//  FanPian
//
//  Created by sa.xiong on 16/1/22.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)

- (CGSize)sizeWithLabel:(UILabel *)label boundingSize:(CGSize)boundingSize {
    CGSize resultSize = [label.text boundingRectWithSize:boundingSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:label.font} context:nil].size;
    
    return resultSize;
}

- (CGSize)sizeWithText:(NSString *)text boundingSize:(CGSize)boundingSize font:(UIFont *)font {
    CGSize resultSize = [text boundingRectWithSize:boundingSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return resultSize;
}


@end
