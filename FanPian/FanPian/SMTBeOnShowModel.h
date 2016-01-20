//
//  SMTBeOnShowModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTBeOnShowListModel.h"

@protocol SMTBeOnShowModel <NSObject>

@end

@interface SMTBeOnShowModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*formhash;
@property (nonatomic, strong) NSNumber <Optional>*nextpage;
@property (nonatomic, strong) NSArray <Optional,SMTBeOnShowListModel>*list;
@end
