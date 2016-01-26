//
//  SMTBeOnShowRequest.m
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTBeOnShowRequest.h"

// mod=movie&type=1&androidflag=1&appfrom=ios&iosversion=3.13&page=1

@implementation SMTBeOnShowRequest
{
    NSNumber *_type;
    NSNumber *_page;
}


- (id)initWithType:(NSNumber *)type page:(NSNumber *)page
{
    self = [super init];
    if (self) {
        _type = type;
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
                 @"mod":@"movie",
                 @"type":[_type stringValue],
                 @"androidflag":@"1",
                 @"appfrom":@"ios",
                 @"iosversion":AppVersion,
                 @"page":[_page stringValue]
                 };
}

@end
