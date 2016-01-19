//
//  SMTBeOnShowModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTBeOnShowListModel.h"

@interface SMTBeOnShowModel : JSONModel
@property (nonatomic, copy) NSString *fromhash;
@property (nonatomic, strong) NSNumber *nextpage;
@property (nonatomic, strong) NSArray <SMTBeOnShowListModel>*list;
@end
