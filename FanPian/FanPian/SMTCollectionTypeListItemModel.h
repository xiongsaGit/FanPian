//
//  SMTCollectionTypeListItemModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@interface SMTCollectionTypeListItemModel : JSONModel
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *isliked;
@property (nonatomic, copy) NSString *liketimes;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *movietid;
@property (nonatomic, copy) NSString *replies;
@property (nonatomic, copy) NSString *special;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *stringName;
@property (nonatomic, strong) NSNumber *width;
@end
