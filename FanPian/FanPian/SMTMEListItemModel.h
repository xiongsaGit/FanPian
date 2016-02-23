//
//  SMTMEListItemModel.h
//  FanPian
//
//  Created by sa.xiong on 16/2/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTShortMovieListModel.h"
@protocol SMTMEListItemModel <NSObject>

@end

@interface SMTMEListItemModel : JSONModel
@property (nonatomic, strong) SMTShortMovieListModel <Optional>*itemdata;
@property (nonatomic, copy) NSString <Optional>*type;
@end
