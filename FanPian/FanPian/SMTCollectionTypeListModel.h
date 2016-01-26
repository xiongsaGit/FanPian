//
//  SMTCollectionTypeListModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTCollectionTypeListModel <NSObject>

@end

@interface SMTCollectionTypeListModel : JSONModel
@property (nonatomic, copy) NSString *type;
@end
