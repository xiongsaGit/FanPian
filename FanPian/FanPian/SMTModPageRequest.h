//
//  SMTModPageRequest.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTBaseRequest.h"

@interface SMTModPageRequest : SMTBaseRequest

- (id)initWithPage:(NSNumber *)page mod:(NSString *)mod;

@end
