//
//  SMTImageListItemModel.h
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTImageListItemModel <NSObject>

@end

@interface SMTImageListItemModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*description;
@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*thumb;
@property (nonatomic, copy) NSString <Optional>*url;
@property (nonatomic, strong) NSNumber <Optional>*width;
@end
