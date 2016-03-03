//
//  ImageVideoView.h
//  ShowImagePlayVideo
//
//  Created by sa.xiong on 16/3/2.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageVideoViewFinishBlock)();

@interface ImageVideoView : UIView

- (id)initWithFinishBlock:(ImageVideoViewFinishBlock)finishBlock;

- (void)loadViewData:(NSDictionary *)dataDict;

@end
