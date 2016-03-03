//
//  SMTThreadgalleryCell.h
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMLBaseCell.h"

// 画报
@class SMTMEListItemModel,SMTThreadgalleryCell;

typedef void(^ThreadgalleryCellItemBlock)(SMTThreadgalleryCell *cell ,NSInteger itemTag);

@interface SMTThreadgalleryCell : SMTMLBaseCell

@property (nonatomic, copy) ThreadgalleryCellItemBlock itemBlock;
@property (nonatomic, assign) CGFloat cellHeight;


- (void)configureGalleryCellData:(SMTMEListItemModel *)itemModel;
@end
