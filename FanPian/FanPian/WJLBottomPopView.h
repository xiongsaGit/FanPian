//
//  WJLBottomPopView.h
//  WJLPopView
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jinbi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WJLBottomPopViewBlock)(int index);

@interface WJLBottomPopView : UIView

@property(nonatomic,copy)WJLBottomPopViewBlock  bottomBolck ;

- (void)setPopViewWithImgs:(NSArray*)imgs andTitles:(NSArray*)titles;

+ (WJLBottomPopView *)share;

@end
