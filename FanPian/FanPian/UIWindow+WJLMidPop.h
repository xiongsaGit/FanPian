//
//  UIWindow+WJLMidPop.h
//  jxtd(锦绣天地)
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 jinbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJLMidPopView.h"
#import "WJLBottomPopView.h"

@interface UIWindow (WJLMidPop)

- (void)showMidPopViewWithImgs:(NSArray*)images andTitles:(NSArray*)titles WithCallBlock:(MidPopViewBlock)callBlock;

- (void)showBottomPopViewWithImgs:(NSArray*)images andTitles:(NSArray*)titles WithCallBlock:(MidPopViewBlock)callBlock;

- (void)dismissView;

@end
