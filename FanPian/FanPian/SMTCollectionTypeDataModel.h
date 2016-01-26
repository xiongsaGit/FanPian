//
//  SMTCollectionTypeDataModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTCollectionTypeModel.h"

@interface SMTCollectionTypeDataModel : JSONModel
@property (nonatomic, strong) SMTCollectionTypeModel *data;
@end