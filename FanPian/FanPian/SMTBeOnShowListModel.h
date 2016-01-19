//
//  SMTBeOnShowListModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTBeOnShowListMovieModel.h"

@protocol SMTBeOnShowListModel<NSObject>

@end


@interface SMTBeOnShowListModel : JSONModel
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *collections;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, strong) NSNumber *isliked;
@property (nonatomic, copy) NSString *liketimes;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) SMTBeOnShowListModel *moviedata;
@property (nonatomic, copy) NSString *replies;
@property (nonatomic, copy) NSString *special;
@property (nonatomic, strong) NSNull *specialname;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *tid;

@end
