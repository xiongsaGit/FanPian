//
//  SMTBarView.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BarViewClickItemBlock)(NSInteger itemTag);

@interface SMTBarView : UIView
@property (nonatomic, strong) NSArray *items;

- (id)initWithFrame:(CGRect)frame clickBlock:(BarViewClickItemBlock)clickBlock;

- (void)configureEventAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked;

- (void)itemLabelTextColor:(UIColor *)textColor;

@end
