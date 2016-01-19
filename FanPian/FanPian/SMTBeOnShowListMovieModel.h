//
//  SMTBeOnShowListMovieModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTBeOnShowListMovieModel<NSObject>


@end

@interface SMTBeOnShowListMovieModel : JSONModel

@property (nonatomic, copy) NSString *casts;
@property (nonatomic, copy) NSString *directors;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSNull *isonline;
@property (nonatomic, copy) NSString *itemaka;
@property (nonatomic, copy) NSString *itemcountries;
@property (nonatomic, copy) NSString *itemgenres;
@property (nonatomic, copy) NSString *itemratingaverage;

@property (nonatomic, copy) NSString *itemratingcount;
@property (nonatomic, copy) NSString *itemruntime;
@property (nonatomic, copy) NSString *itemsummary;
@property (nonatomic, strong) NSNumber *itemyear;
@property (nonatomic, copy) NSString *movieshowflag;
@property (nonatomic, copy) NSString *movieshowurl;
@property (nonatomic, strong) NSDictionary *original_title;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNull *trailerflag;
@property (nonatomic, copy) NSString *trailerurl;
@property (nonatomic, strong) NSNumber *width;

@end
