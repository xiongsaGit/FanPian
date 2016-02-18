//
//  SMTShowViewController.h
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef NS_ENUM(NSInteger,MovieTypeFrom) {
//    MovieTypeFromDefault = 0,// 上映
//    MovieTypeFromCollection,//影单详情
//};

// 上映
@interface SMTShowViewController : UIViewController

- (id)initWithType:(MovieTypeFrom)type title:(NSString *)title ctid:(NSString *)ctid;

@end
