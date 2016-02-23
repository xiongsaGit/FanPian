//
//  SMTMainHeader.m
//  FanPian
//
//  Created by sa.xiong on 16/2/22.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMainHeader.h"
#import "SMTOperateView.h"

@interface SMTMainHeader()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *horizonScrollView;
@property (nonatomic, strong) SMTOperateView *operateView;
@end
@implementation SMTMainHeader

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
        [self configureFrame];
    }
    return self;
}

- (void)setOperateItems:(NSMutableArray *)operateItems {
    _operateItems = operateItems;
    
    self.operateView.dataItems = operateItems;
}

- (void)configureUI {
//    [self addSubview:self.horizonScrollView];
    [self addSubview:self.operateView];
}

- (void)configureFrame {
    [self.operateView setFrame:CGRectMake(0, 30, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-30)];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


- (UIScrollView *)horizonScrollView {
    if (!_horizonScrollView) {
        _horizonScrollView = [[UIScrollView alloc] init];
        _horizonScrollView.delegate = self;
        _horizonScrollView.showsHorizontalScrollIndicator = NO;
        _horizonScrollView.showsVerticalScrollIndicator = NO;
        _horizonScrollView.bounces = NO;
    }
    return _horizonScrollView;
}

- (SMTOperateView *)operateView {
    if (!_operateView) {
        _operateView = [[SMTOperateView alloc] init];
    }
    return _operateView;
}

@end
