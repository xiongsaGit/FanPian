//
//  SMTHeaderView.h
//  LabelOnImageView
//
//  Created by sa.xiong on 16/1/26.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderViewItemClickBlock)(NSInteger itemTag);

@interface SMTHeaderView : UIView

- (id)initWithItemClickBlock:(HeaderViewItemClickBlock)clickBlock;

- (void)loadDataArray:(NSArray *)data;


@end
