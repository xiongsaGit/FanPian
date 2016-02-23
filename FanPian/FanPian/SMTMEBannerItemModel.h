//
//  SMTMEBannerItemModel.h
//  FanPian
//
//  Created by sa.xiong on 16/2/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTMEBannerItemModel <NSObject>

@end


@interface SMTMEBannerItemModel : JSONModel

@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*image;
@property (nonatomic, copy) NSString <Optional>*intro;
@property (nonatomic, strong) NSNumber <Optional>*ishaveintro;
@property (nonatomic, copy) NSString <Optional>*itemid;
@property (nonatomic, copy) NSString <Optional>*subject;
@property (nonatomic, copy) NSString <Optional>*type;
@property (nonatomic, strong) NSNumber <Optional>*width;

@end
