//
//  SMTSalonDetailHeader.h
//  FanPian
//
//  Created by sa.xiong on 16/1/27.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SalonDetailHeaderDelegate <NSObject>
- (void)refreshHeightOfHeader:(CGFloat)heightOfHeader;
@end

@class SMTSalonDetailModel;
@interface SMTSalonDetailHeader : UIView
@property (nonatomic, assign) id<SalonDetailHeaderDelegate> headerDelegate;

- (void)configureData:(SMTSalonDetailModel *)model;

@end

