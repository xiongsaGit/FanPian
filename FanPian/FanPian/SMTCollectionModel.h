//
//  SMTCollectionModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTCollectionListModel.h"

@protocol SMTCollectionModel <NSObject>

@end

@interface SMTCollectionModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*formhash;
@property (nonatomic, strong) NSNumber <Optional>*nextpage;
@property (nonatomic, strong) NSArray <Optional,SMTCollectionListModel>*list;

@end
