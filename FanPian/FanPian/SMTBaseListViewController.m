//
//  SMTBaseListViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/20.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTBaseListViewController.h"

static NSString *const CellIdentifier = @"cellIdentifier";

@interface SMTBaseListViewController()<UITableViewDelegate>

@end


@implementation SMTBaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemHeight = 44.0f;
    self.dataItems = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    [self setupTableView];
    
    [self defaultRequestData];
}

- (void)setupTableView {
    
    TableViewCellConfigureBlock configureBlock;

    self.tableDataSource = [[SMTTableDataSource alloc] initWithDataItems:self.dataItems cellIdentifier:CellIdentifier cellConfigureBlock:configureBlock];
    
    self.tableView.dataSource = self.tableDataSource;
    
}

- (void)defaultRequestData {
    NSLog(@"log default request");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectItemAtIndexPath:indexPath];
}

- (void)headerRefreshEvent {
    
}

- (void)footerLoadMoreEvent {
    
}

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}


@end
