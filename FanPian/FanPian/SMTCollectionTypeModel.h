//
//  SMTCollectionTypeModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTCollectionTypeListModel.h"

@protocol SMTCollectionTypeModel <NSObject>

@end

@interface SMTCollectionTypeModel : JSONModel
@property (nonatomic, copy) NSString *commentnum;
@property (nonatomic, copy) NSString *ctid;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *formhash;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSNumber *isfollowed;
@property (nonatomic, copy) NSNumber *ismycreated;
@property (nonatomic, strong) NSArray <SMTCollectionTypeListModel>*list;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *nextpage;
@property (nonatomic, copy) NSString *threadnum;

@end
