//
//  SMTFooter.h
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FooterClickBlock)();

@interface SMTFooter : UIView

- (id)initWithClickBlock:(FooterClickBlock)clickBlock;

- (void)configureTitleLabel:(NSString *)title;

- (void)configureDetailLabel:(NSString *)title;

@end
