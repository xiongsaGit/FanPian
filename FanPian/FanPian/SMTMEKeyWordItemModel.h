//
//  SMTMEKeyWordItemModel.h
//  FanPian
//
//  Created by sa.xiong on 16/2/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTMEKeyWordItemModel <NSObject>

@end

@interface SMTMEKeyWordItemModel : JSONModel
@property (nonatomic, copy) NSString *itemid;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *type;

@end
