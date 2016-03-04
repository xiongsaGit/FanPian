//
//  RHCTimer.h
//  Renrenlicai_ios_instalment
//
//  Created by sa.xiong on 15/11/26.
//  Copyright © 2015年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^EndBlock)();
typedef void(^ContinueBlock)(long remainTime);
typedef dispatch_source_t(^CountTimer)(long countTime,EndBlock endBlock ,ContinueBlock continueBlock);


@interface RHCTimer : NSObject

+ (dispatch_source_t)timerWithCountDownTime:(long)countdownTime endBlock:(EndBlock)endBlock continueBlock:(ContinueBlock)continueBlock;

@end
