//
//  SMTSalonCell.h
//  FanPian
//
//  Created by sa.xiong on 16/1/26.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMTSalonListModel;
@interface SMTSalonCell : UITableViewCell

- (void)configureData:(SMTSalonListModel *)listModel;

@end
