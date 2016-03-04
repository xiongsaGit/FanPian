//
//  ImageVideoView.h
//  ShowImagePlayVideo
//
//  Created by sa.xiong on 16/3/2.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageVideoViewSkipBlock)();

@interface ImageVideoView : UIView

- (id)initWithSkipBlock:(ImageVideoViewSkipBlock)skipBlock;

- (void)loadViewData:(NSDictionary *)dataDict;

@end
