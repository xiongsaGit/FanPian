//
//  SMTMLBaseCell.h
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMTMLBaseCell : UITableViewCell
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UIButton *lookBtn;
- (void)showTypeTextWithType:(NSString *)type;

@end
