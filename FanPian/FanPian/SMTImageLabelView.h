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

- (id)initWithFrame:(CGRect)frame type:(ImageLabelType)type block:(ImageLabelViewBlock)block;

- (void)configureImageName:(NSString *)imageName labelTitle:(NSString *)title;

@end
