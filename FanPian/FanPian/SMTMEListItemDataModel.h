//
//  SMTMEListItemDataModel.h
//  FanPian
//
//  Created by sa.xiong on 16/2/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTMEListItemDataModel <NSObject>

@end
@interface SMTMEListItemDataModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*author;
@property (nonatomic, copy) NSString <Optional>*authorid;
@property (nonatomic, copy) NSString <Optional>*dateline;
@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*image;
@property (nonatomic, copy) NSString <Optional>*intro;
@property (nonatomic, strong) NSNumber <Optional>*isliked;

@property (nonatomic, copy) NSString <Optional>*liketimes;
@property (nonatomic, copy) NSString <Optional>*message;
@property (nonatomic, copy) NSString <Optional>*movietid;
@property (nonatomic, copy) NSString <Optional>*replies;
@property (nonatomic, copy) NSString <Optional>*special;
@property (nonatomic, copy) NSString <Optional>*subject;
@property (nonatomic, copy) NSString <Optional>*tid;
@property (nonatomic, strong) NSNumber *width;

@end
