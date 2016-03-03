//
//  SMTMLChannelCell.h
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMLBaseCell.h"

// 沙龙
@class SMTMEListItemModel;
@interface SMTMLChannelCell : SMTMLBaseCell
@property (nonatomic, assign) CGFloat cellHeight;

- (void)configureCellForData:(SMTMEListItemModel *)itemModel;

@end
