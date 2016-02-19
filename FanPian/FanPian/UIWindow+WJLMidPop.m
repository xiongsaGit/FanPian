//
//  UIWindow+WJLMidPop.m
//  jxtd(锦绣天地)
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 jinbi. All rights reserved.
//

#import "UIWindow+WJLMidPop.h"

#define buttonW 50 //每个弹出视图里面按钮的高度

UIButton *maskBt;

@implementation UIWindow (WJLMidPop)

- (void)addMidView:(UIView*)midView WithSubviewsCount:(int)count{
    CGFloat screenW =  [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH =  [UIScreen mainScreen].bounds.size.height;
    CGFloat midH = count * (buttonW) + (count - 1);
    CGFloat midW = screenW*0.8;
    midView.bounds = CGRectMake(0, 0, midW, midH);
    midView.center = CGPointMake(screenW/2, screenH/2);
    [self addSubview:midView];
}
- (void)addBottomView:(UIView*)midView WithSubviewsCount:(int)count{
    CGFloat screenW =  [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH =  [UIScreen mainScreen].bounds.size.height;
    CGFloat midH = count * (buttonW) + (count - 1);
    CGFloat midW = screenW*0.9;
    midView.frame = CGRectMake((screenW - midW)/2, screenH, midW, midH);
    [self addSubview:midView];
    [UIView animateWithDuration:0.2 animations:^{
        midView.transform = CGAffineTransformMakeTranslation(0, -midH);
    }];
    
}

- (void)showMidPopViewWithImgs:(NSArray*)images andTitles:(NSArray*)titles WithCallBlock:(MidPopViewBlock)callBlock{
    
    WJLMidPopView *midPop = [WJLMidPopView share];
    
    [midPop setPopViewWithImgs:images andTitles:titles];
    
    midPop.midBlck = callBlock;
    
    [self addMask];
    [self addMidView:midPop WithSubviewsCount:(int)titles.count];
}
- (void)showBottomPopViewWithImgs:(NSArray*)images andTitles:(NSArray*)titles WithCallBlock:(MidPopViewBlock)callBlock{
    
    WJLBottomPopView *botPopView = [WJLBottomPopView share];
    
    [botPopView setPopViewWithImgs:images andTitles:titles];
    
    botPopView.bottomBolck = callBlock;
    
    [self addMask];
    
    [self addBottomView:botPopView WithSubviewsCount:(int)titles.count];
    
}

- (void)addMask{
    maskBt = [[UIButton alloc]init];
    maskBt.frame = self.bounds;
    maskBt.backgroundColor = [UIColor blackColor];
    maskBt.alpha = 0.5;
    [maskBt addTarget:self action:@selector(maskClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:maskBt];
    
}
- (void)maskClick{
//    [self dismissView];

}
- (void)dismissView{

    [[WJLMidPopView share] removeFromSuperview];
    [[WJLBottomPopView share] removeFromSuperview];
    [WJLBottomPopView share].transform = CGAffineTransformIdentity;
    [maskBt removeFromSuperview];
}

@end
