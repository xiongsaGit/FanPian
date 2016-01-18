//
//  SMTScrollView.m
//  FanPian
//
//  Created by sa.xiong on 16/1/17.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTScrollView.h"

@implementation SMTScrollView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}


- (void)setViewsArray:(NSArray *)viewsArray {
    _viewsArray = viewsArray;
    
    [self addViews];
}

- (void)addViews {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    
    for (int i = 0 ; i < _viewsArray.count; i ++) {
        UIView *tempView = _viewsArray[i];
        // 设置origin
      
        tempView.frame =  CGRectMake(CGRectGetWidth(self.frame)*i, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

        [self addSubview:tempView];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
