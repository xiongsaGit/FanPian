//
//  SMTCollectionRequest.m
//  FanPian
//
//  Created by sa.xiong on 16/1/22.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTCollectionRequest.h"

@implementation SMTCollectionRequest
{
    NSNumber *_page;
}

- (id)initWithPage:(NSNumber *)page
{
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
             @"androidflag":@"1",
             @"op":@"recommend",
             @"appfrom":@"ios",
             @"iosversion":AppVersion,
             @"page":[_page stringValue]
             };
}
@end
