//
//  SMTCollectionTypeRequest.m
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTCollectionTypeRequest.h"

@implementation SMTCollectionTypeRequest
{
    NSNumber *_page;
    NSString *_ctid;
}

- (id)initWithPage:(NSNumber *)page ctid:(NSString *)ctid
{
    self = [super init];
    if (self) {
        _page = page;
        _ctid = ctid;
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
             @"action":@"view",
             @"ctid":_ctid,
             @"v":@"2",
             @"androidflag":@"1",
             @"appfrom":@"ios",
             @"iosversion":AppVersion,
             @"page":[_page stringValue]
             };
}

@end
