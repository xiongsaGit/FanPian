//
//  ShowLabelOnImageView.h
//  LabelOnImageView
//
//  Created by sa.xiong on 16/1/25.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowLabelOnImageView;
typedef void(^LabelOnImageViewClickBlock)(ShowLabelOnImageView *item);

@interface ShowLabelOnImageView : UIImageView

- (id)initWithClickBlock:(LabelOnImageViewClickBlock)clickBlock;


- (void)showTextWithIntro:(NSString *)intro subject:(NSString *)subject;

- (void)showImageWithImagePath:(NSString *)imagePath;

@end
