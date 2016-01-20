//
//  SMTBaseListViewController.h
//  FanPian
//
//  Created by sa.xiong on 16/1/20.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMTBaseListViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceItems;
@end
