//
//  SMTImageTitleDescCell.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 格式：图片 标题 简介
@class SMTImageTitleDescCell,SMTShortMovieListModel;

@protocol SMTShortMovieCellDelegate <NSObject>
- (void)playVideoWithUrlString:(NSString *)videoUrl;
@end

typedef void(^ShortMovieCellItemBlock)(SMTImageTitleDescCell *cell ,NSInteger itemTag);

@interface SMTImageTitleDescCell : UITableViewCell

@property (nonatomic, copy) ShortMovieCellItemBlock itemBlock;

- (void)configureCellData:(SMTShortMovieListModel *)listModel;

- (void)configureBarViewAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked;

@end
