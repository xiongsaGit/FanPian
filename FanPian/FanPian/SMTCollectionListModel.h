//
//  SMTCollectionListModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTCollectionListModel <NSObject>

@end

@interface SMTCollectionListModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*ctid;
@property (nonatomic, copy) NSString <Optional>*desc;
@property (nonatomic, copy) NSString <Optional>*image;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*threadnum;

@end


