//
//  SMTListViewController.h
//  FanPian
//
//  Created by sa.xiong on 16/1/14.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHCArrayDataSource.h"

@interface SMTListViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) TableViewCellConfigureBlock configureCell;
@property (nonatomic, strong) RHCArrayDataSource *arrayDataSource;
@property (nonatomic, strong) NSMutableArray *mutArray;

@end
