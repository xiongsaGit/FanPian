//
//  SMTSalonDetailModel.h
//  FanPian
//
//  Created by sa.xiong on 16/1/27.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTSalonDetailListModel.h"

@protocol SMTSalonDetailModel <NSObject>

@end

@interface SMTSalonDetailModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*createtime;
@property (nonatomic, copy) NSString <Optional>*ctid;
@property (nonatomic, copy) NSString <Optional>*desc;
@property (nonatomic, copy) NSString <Optional>*formhash;
@property (nonatomic, copy) NSString <Optional>*founderuid;
@property (nonatomic, copy) NSString <Optional>*founderusername;
@property (nonatomic, strong) NSNumber <Optional>*height;
@property (nonatomic, copy) NSString <Optional>*icon;
@property (nonatomic, strong) NSNumber <Optional>*isfollowed;
@property (nonatomic, strong) NSNumber <Optional>*ismycreated;
@property (nonatomic, strong) NSArray <Optional,SMTSalonDetailListModel>*list;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, strong) NSNumber <Optional>*nextpage;
@property (nonatomic, copy) NSString <Optional>*threadnum;
@property (nonatomic, strong) NSNumber <Optional>*width;




@end
