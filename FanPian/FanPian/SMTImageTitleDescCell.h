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
@property (nonatomic, assign) CGFloat cellHeight;
- (void)configureCellData:(SMTShortMovieListModel *)listModel;
- (void)configureCellData:(SMTShortMovieListModel *)listModel withType:(NSString *)type;

- (void)configureCellData:(SMTShortMovieListModel *)listModel withLookMore:(BOOL)hasMore withType:(NSString *)type;

- (void)configureBarViewAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked;

- (void)hideLookButton:(BOOL)hidden;

@end
