//
//  SMTShortMovieCell.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMTShortMovieCell,SMTShortMovieListModel;

@protocol SMTShortMovieCellDelegate <NSObject>
- (void)playVideoWithUrlString:(NSString *)videoUrl;
@end

typedef void(^ShortMovieCellItemBlock)(SMTShortMovieCell *cell ,NSInteger itemTag);

@interface SMTShortMovieCell : UITableViewCell

@property (nonatomic, copy) ShortMovieCellItemBlock itemBlock;

- (void)configureCellData:(SMTShortMovieListModel *)listModel;

- (void)configureBarViewAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked;

@end
