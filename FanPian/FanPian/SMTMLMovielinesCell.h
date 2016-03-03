//
//  SMTMLMovielinesCell.h
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMLBaseCell.h"

@class SMTMLMovielinesCell,SMTMEListItemModel;
typedef void(^MovielinesCellItemBlock)(SMTMLMovielinesCell *cell ,NSInteger itemTag);

// 台词
@interface SMTMLMovielinesCell : SMTMLBaseCell
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) MovielinesCellItemBlock itemBlock;
- (void)configureCellForData:(SMTMEListItemModel *)itemModel;

@end
