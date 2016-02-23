//
//  SMTOperateView.m
//  FanPian
//
//  Created by sa.xiong on 16/2/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTOperateView.h"
#import "SMTImageLabelView.h"

@implementation SMTOperateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataItems = [NSMutableArray array];
    }
    return self;
}

- (void)setDataItems:(NSMutableArray *)dataItems {
    _dataItems = dataItems;
    
    [self addItems:dataItems];
    
}

- (void)addItems:(NSMutableArray *)items {
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat perWidth = CGRectGetWidth(self.frame)/items.count;
    for (int i = 0; i < items.count; i++) {
        
        SMTImageLabelView *imageLabelView = [[SMTImageLabelView alloc] initWithFrame:CGRectMake(i*perWidth, 0, perWidth, CGRectGetHeight(self.frame)) type:ImageLabelTypeImageOn block:^{
            NSLog(@"click item :%d",i);
        }];
        NSDictionary *item = items[i];
        [imageLabelView configureImageName:item[@"imageName"] labelTitle:item[@"titleContent"]];
        [self addSubview:imageLabelView];
    }
    
}


@end
