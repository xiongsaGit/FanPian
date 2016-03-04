//
//  RHCTimer.m
//  Renrenlicai_ios_instalment
//
//  Created by sa.xiong on 15/11/26.
//  Copyright © 2015年 renren. All rights reserved.
//

#import "RHCTimer.h"

@implementation RHCTimer

+ (dispatch_source_t)timerWithCountDownTime:(long)countdownTime endBlock:(EndBlock)endBlock continueBlock:(ContinueBlock)continueBlock;
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    __block long timeout = countdownTime;
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                endBlock();
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                continueBlock(timeout);
            });
            timeout--;
            NSLog(@"timeout:%ld",timeout);
        }
    });
    dispatch_resume(timer);
    
    return timer;
}


@end
