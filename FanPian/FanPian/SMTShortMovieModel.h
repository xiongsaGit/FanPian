//
//  SMTShortMovieModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTShortMovieListModel.h"

@protocol SMTShortMovieModel <NSObject>

@end

@interface SMTShortMovieModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*formhash;
@property (nonatomic, strong) NSNumber <Optional>*nextpage;
@property (nonatomic, strong) NSArray <Optional,SMTShortMovieListModel>*list;

@end
