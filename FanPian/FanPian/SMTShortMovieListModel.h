//
//  SMTShortMovieListModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTImageListItemModel.h"

@protocol SMTShortMovieListModel <NSObject>

@end

@interface SMTShortMovieListModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*author;
@property (nonatomic, copy) NSString <Optional>*authorid;
@property (nonatomic, copy) NSString <Optional>*dateline;

@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*image;
@property (nonatomic, copy) NSString <Optional>*intro;
@property (nonatomic, strong) NSNumber <Optional>*isliked;
@property (nonatomic, copy) NSString <Optional>*liketimes;
@property (nonatomic, copy) NSString <Optional>*movietid;
@property (nonatomic, copy) NSString <Optional>*replies;
@property (nonatomic, copy) NSString <Optional>*special;
@property (nonatomic, copy) NSString <Optional>*subject;
@property (nonatomic, copy) NSString <Optional>*tid;
@property (nonatomic, copy) NSString <Optional>*videlurl;
@property (nonatomic, strong) NSNumber <Optional>*width;
// 
@property (nonatomic, copy) NSString <Optional>*message;
@property (nonatomic, copy) NSString <Optional>*ctid;
@property (nonatomic, copy) NSString <Optional>*desc;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*threadnum;
//
@property (nonatomic, strong) NSNumber <Optional>*imagecount;
@property (nonatomic, strong) NSArray <Optional,SMTImageListItemModel>*imagelist;
@end
