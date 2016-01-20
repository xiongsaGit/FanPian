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

@property (nonatomic, copy) NSString <Optional>*casts;
@property (nonatomic, copy) NSString <Optional>*directors;
@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*image;

@property (nonatomic, copy) NSString <Optional>*isonline;
@property (nonatomic, copy) NSString <Optional>*itemaka;
@property (nonatomic, copy) NSString <Optional>*itemcountries;
@property (nonatomic, copy) NSString <Optional>*itemgenres;
@property (nonatomic, copy) NSString <Optional>*itemratingaverage;

@property (nonatomic, copy) NSString <Optional>*itemratingcount;
@property (nonatomic, copy) NSString <Optional>*itemruntime;
@property (nonatomic, copy) NSString <Optional>*itemsummary;
@property (nonatomic, strong) NSNumber <Optional>*itemyear;
@property (nonatomic, copy) NSString <Optional>*movieshowflag;
@property (nonatomic, copy) NSString <Optional>*movieshowurl;
@property (nonatomic, copy) NSString <Optional>*original_title;
@property (nonatomic, copy) NSString <Optional>*pubdate;
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*trailerflag;
@property (nonatomic, copy) NSString <Optional>*trailerurl;
@property (nonatomic, strong) NSNumber <Optional>*width;

@end
