//
//  SMTCollectionCell.h
//  FanPian
//
//  Created by sa.xiong on 16/1/22.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMTCollectionListModel;
@interface SMTCollectionCell : UITableViewCell

- (void)configureCellData:(SMTCollectionListModel *)listModel;


@end
