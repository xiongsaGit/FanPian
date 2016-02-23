//
//  SMTModPageRequest.m
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTModPageRequest.h"

@implementation SMTModPageRequest
{
    NSNumber *_page;
    NSString *_mod;
}

- (id)initWithPage:(NSNumber *)page mod:(NSString *)mod
{
    self = [super init];
    if (self) {
        _page = page;
        _mod = mod;
    }
    return self;
}


- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

- (id)requestArgument
{
    
    return @{
             @"mod":_mod,
             @"androidflag":@"1",
             @"appfrom":@"ios",
             @"iosversion":AppVersion,
             @"page":[_page stringValue]
             };
}

@end
