//
//  SMTSalonDetailCell.h
//  FanPian
//
//  Created by sa.xiong on 16/1/27.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMTSalonDetailListModel;
@interface SMTSalonDetailCell : UITableViewCell


- (void)configureData:(SMTSalonDetailListModel *)listModel;
@end
