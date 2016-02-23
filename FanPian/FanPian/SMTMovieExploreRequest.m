//
//  SMTMovieExploreRequest.m
//  FanPian
//
//  Created by sa.xiong on 16/2/22.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMovieExploreRequest.h"

@implementation SMTMovieExploreRequest
{
    NSNumber *_page;
    NSString *_pdateline;
}

- (id)initWithPage:(NSNumber *)page pdateline:(NSString *)pdateline {
    self = [super init];
    if (self) {
        _page = page;
        _pdateline = pdateline;
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
             @"mod":@"movieexplorer",
             @"v":@"3",
             @"androidflag":@"1",
             @"appfrom":@"ios",
             @"iosversion":AppVersion,
             @"page":[_page stringValue]
             };
}

@end
