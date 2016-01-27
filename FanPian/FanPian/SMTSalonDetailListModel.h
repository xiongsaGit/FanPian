//
//  SMTSalonDetailListModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/27.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTSalonDetailListModel <NSObject>

@end

@interface SMTSalonDetailListModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*author;
@property (nonatomic, copy) NSString <Optional>*authorid;
@property (nonatomic, copy) NSString <Optional>*dateline;
@property (nonatomic, copy) NSString <Optional>*fid;
@property (nonatomic, copy) NSString <Optional>*fpbbsctypeid;
@property (nonatomic, copy) NSString <Optional>*fpbbsmessageempty;
@property (nonatomic, copy) NSString <Optional>*fpbbsmovietid;
@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*image;
@property (nonatomic, strong) NSNumber <Optional>*isliked;
@property (nonatomic, copy) NSString <Optional>*liketimes;
@property (nonatomic, copy) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <Optional>*moviedata;
@property (nonatomic, copy) NSString <Optional>*replies;
@property (nonatomic, copy) NSString <Optional>*special;
@property (nonatomic, copy) NSString <Optional>*subject;
@property (nonatomic, copy) NSString <Optional>*tid;
@property (nonatomic, strong) NSNumber <Optional>*width;

@end
