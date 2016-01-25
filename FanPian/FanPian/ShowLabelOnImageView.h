//
//  ShowLabelOnImageView.h
//  LabelOnImageView
//
//  Created by sa.xiong on 16/1/25.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowLabelOnImageView : UIImageView

- (void)showTextWithIntro:(NSString *)intro subject:(NSString *)subject;

- (void)showImageWithImagePath:(NSString *)imagePath;

@end
