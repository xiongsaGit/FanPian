//
//  SMTSalonRequest.m
//  FanPian
//
//  Created by sa.xiong on 16/1/26.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTSalonRequest.h"

@implementation SMTSalonRequest
{
    NSNumber *_page;
}

- (id)initWithPage:(NSNumber *)page {
    self = [super init];
    if (self) {
        _page = page;
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
             @"mod":@"collection",
             @"op":@"channel",
             @"androidflag":@"1",
             @"appfrom":@"ios",
             @"iosversion":AppVersion,
             @"page":[_page stringValue]
             };
}

@end
