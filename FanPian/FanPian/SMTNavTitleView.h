//
//  SMTNavTitleView.h
//  FanPian
//
//  Created by sa.xiong on 16/1/14.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavTitleItemClickBlcok)(NSInteger itemTag);

@interface SMTNavTitleView : UIView

- (id)initWithFrame:(CGRect)frame
              items:(NSArray *)items
         clickBlock:(NavTitleItemClickBlcok)itemClcikBlock;

- (void)selectItem:(NSInteger)index;

- (void)resizeButtonTitleFontSize:(CGFloat)fontSize;

@end
