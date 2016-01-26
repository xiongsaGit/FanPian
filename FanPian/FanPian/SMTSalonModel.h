//
//  SMTSalonModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/26.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTSalonListModel.h"

@protocol SMTSalonModel <NSObject>

@end

@interface SMTSalonModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*formhash;
@property (nonatomic, strong) NSNumber <Optional>*nextpage;
@property (nonatomic, strong) NSArray <Optional,SMTSalonListModel>*list;

@end
