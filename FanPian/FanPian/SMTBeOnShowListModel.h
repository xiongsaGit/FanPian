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
@property (nonatomic, copy) NSString <Optional>*author;
@property (nonatomic, copy) NSString <Optional>*authorid;
@property (nonatomic, copy) NSString <Optional>*collections;
@property (nonatomic, copy) NSString <Optional>*dateline;
@property (nonatomic, copy) NSString <Optional>*fid;
@property (nonatomic, strong) NSNumber <Optional>*isliked;
@property (nonatomic, copy) NSString <Optional>*liketimes;
@property (nonatomic, copy) NSString <Optional>*message;
@property (nonatomic, strong) SMTBeOnShowListMovieModel *moviedata;
@property (nonatomic, copy) NSString    <Optional>*replies;
@property (nonatomic, copy) NSString <Optional>*special;
@property (nonatomic, copy) NSString <Optional>*specialname;
@property (nonatomic, copy) NSString <Optional>*subject;
@property (nonatomic, copy) NSString <Optional>*tid;

@end
