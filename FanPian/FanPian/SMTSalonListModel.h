//
//  SMTSalonListModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/26.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"

@protocol SMTSalonListModel <NSObject>

@end


@interface SMTSalonListModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*ctid;
@property (nonatomic, copy) NSString <Optional>*desc;
@property (nonatomic, copy) NSString <Optional>*follownum;
@property (nonatomic, copy) NSString <Optional>*founderuid;
@property (nonatomic, copy) NSString <Optional>*founderusername;

@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*icon;
@property (nonatomic, strong) NSNumber <Optional>*isfollowed;
@property (nonatomic, strong) NSNumber <Optional>*issue;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*threadnum;
@property (nonatomic, strong) NSNumber <Optional>*width;

@end
