//
//  SMTMovieExplorerModel.h
//  FanPian
//
//  Created by sa.xiong on 16/2/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "JSONModel.h"
#import "SMTMEBannerItemModel.h"
#import "SMTMEKeyWordItemModel.h"
#import "SMTMEListItemModel.h"

@protocol SMTMovieExplorerModel <NSObject>

@end

@interface SMTMovieExplorerModel : JSONModel
@property (nonatomic, strong) NSNumber *explorerbannercount;
@property (nonatomic, strong) NSArray <Optional,SMTMEBannerItemModel>*explorerbannerlist;
@property (nonatomic, strong) NSNumber *explorerhotkeywordcount;
@property (nonatomic, strong) NSArray <Optional,SMTMEKeyWordItemModel>*explorerhotkeywordlist;

@property (nonatomic, copy) NSString *formhash;

@property (nonatomic, strong) NSArray <Optional,SMTMEListItemModel>*list;

@property (nonatomic, strong) NSNumber *nextpage;
@property (nonatomic, strong) NSNumber *pdateline;

@end
