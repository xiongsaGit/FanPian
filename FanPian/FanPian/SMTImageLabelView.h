//
//  SMTImageLabelView.h
//  FanPian
//
//  Created by sa.xiong on 16/1/18.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ImageLabelType) {
    ImageLabelTypeImageLeft,
    ImageLabelTypeImageOn,

};

typedef void(^ImageLabelViewBlock)();

@interface SMTImageLabelView : UIView
@property (nonatomic, copy) ImageLabelViewBlock clickBlock;

- (id)initWithFrame:(CGRect)frame type:(ImageLabelType)type;

- (id)initWithFrame:(CGRect)frame type:(ImageLabelType)type block:(ImageLabelViewBlock)block;

- (void)configureImageName:(NSString *)imageName labelTitle:(NSString *)title;

- (void)configureWitState:(BOOL)isChecked;

@end
