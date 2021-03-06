//
//  UIView+Size.h
//  FanPian
//
//  Created by sa.xiong on 16/1/22.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Size)

- (CGSize)sizeWithLabel:(UILabel *)label boundingSize:(CGSize)boundingSize;

- (CGSize)sizeWithText:(NSString *)text boundingSize:(CGSize)boundingSize font:(UIFont *)font;

@end
