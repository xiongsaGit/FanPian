//
//  SMTBaseListViewController.h
//  FanPian
//
//  Created by sa.xiong on 16/1/20.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTTableDataSource.h"

@interface SMTBaseListViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataItems;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SMTTableDataSource *tableDataSource;

@property (nonatomic, assign) CGFloat itemHeight;


- (void)setupTableView;

- (void)defaultRequestData;

- (void)headerRefreshEvent;

- (void)footerLoadMoreEvent;

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath;

@end