//
//  WJLMidPopView.h
//  jxtd(锦绣天地)
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 jinbi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MidPopViewBlock)(int index);

@interface WJLMidPopView : UIView

@property(nonatomic,copy)MidPopViewBlock  midBlck ;

/**
    设置中间弹出视图
 */
- (void)setPopViewWithImgs:(NSArray*)imgs andTitles:(NSArray*)titles;



+ (WJLMidPopView*)share;

@end
