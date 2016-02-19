//
//  WJLMidPopView.m
//  jxtd(锦绣天地)
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 jinbi. All rights reserved.
//

#import "WJLMidPopView.h"
#import "UIWindow+WJLMidPop.h"

#define ButtonTag 10


static const CGFloat margin = 1;
static const CGFloat imgTitleMargin = 20;//按钮图片和文字间隔

@implementation WJLMidPopView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setPopViewWithImgs:(NSArray*)imgs andTitles:(NSArray*)titles{
    
     [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [obj removeFromSuperview];
     }];
    
//    if (imgs.count <=  0) {
//       
//        return;
//    }
//    if (imgs.count != titles.count) {
//        NSLog(@"图片必须和文本一样数量");
//        return;
//    }
    for (int i = 0; i < titles.count ; i ++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        if (imgs.count>=titles.count) {
            NSString *img = imgs[i];
            [bt setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
            if (img.length >= 1) { //有图片的话就设置图片和文字的间距
                bt.titleEdgeInsets = UIEdgeInsetsMake(0, imgTitleMargin, 0, 0);
            }
        }
        NSString *title = titles[i];
        [bt setTitle:title forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.tag =  ButtonTag + i ;
        bt.backgroundColor = [UIColor whiteColor];
       
       
        [bt addTarget:self action:@selector(didSelectAtButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt];
    }
}

 
- (void)layoutSubviews{
    CGFloat btW = self.frame.size.width;
    CGFloat btH = (self.frame.size.height - margin*(self.subviews.count - 1))/self.subviews.count ;
    for (int i = 0 ; i < self.subviews.count ; i ++) {
        UIButton *bt = self.subviews[i];
        bt.frame = CGRectMake(0, i * (btH + margin ), btW, btH);
    }
}

- (void)didSelectAtButton:(UIButton *)sender {
    MidPopViewBlock block = self.midBlck;
    if (block) {
        if ((int)sender.tag - ButtonTag != 0) {
            block((int)sender.tag - ButtonTag);
   
        }
    }
    if ((int)sender.tag - ButtonTag != 0) {

    [self.window dismissView];
    }
}

+ (WJLMidPopView*)share{
  static  WJLMidPopView *view = nil;
    if (view  == nil) {
        view = [[WJLMidPopView alloc]init];
    }
    return view;
}
@end
