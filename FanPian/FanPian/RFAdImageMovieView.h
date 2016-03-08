//
//  RFAdImageMovieView.h
//  RFByStages
//
//  Created by sa.xiong on 16/3/7.
//  Copyright © 2016年 renren-fenqi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ImageVideoViewSkipBlock)();

@interface RFAdImageMovieView : UIView
@property (nonatomic, assign) NSInteger timeDuration;

- (id)initWithSkipBlock:(ImageVideoViewSkipBlock)skipBlock;
- (void)loadViewData:(NSDictionary *)dataDict;

@end

@interface NSTimer (HandleEvent)

-(void)resumeTimer;
-(void)pauseTimer;

@end