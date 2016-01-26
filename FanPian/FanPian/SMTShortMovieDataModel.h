//
//  SMTShortMovieDataModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTShortMovieModel.h"

@interface SMTShortMovieDataModel : JSONModel
@property (nonatomic, strong) SMTShortMovieModel *data;
@end
