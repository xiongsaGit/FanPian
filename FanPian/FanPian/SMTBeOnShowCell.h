//
//  SMTBeOnShowCell.h
//  FanPian
//
//  Created by sa.xiong on 16/1/20.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMTShortMovieCell,SMTBeOnShowCell;
typedef void(^BeOnShowCellItemBlock)(SMTBeOnShowCell *cell ,NSInteger itemTag);


@class SMTBeOnShowListModel;
@interface SMTBeOnShowCell : UITableViewCell
@property (nonatomic, copy) BeOnShowCellItemBlock itemBlock;

- (void)configureCellData:(SMTBeOnShowListModel *)listModel;

- (void)configureBarViewAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked;

@end
