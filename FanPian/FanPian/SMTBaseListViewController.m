//
//  SMTBaseListViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/20.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTBaseListViewController.h"

@interface SMTBaseListViewController()<UITableViewDelegate,UITableViewDataSource>

@end


@implementation SMTBaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSourceItems = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    

}

- (void)setDataSourceItems:(NSMutableArray *)dataSourceItems {
    _dataSourceItems = dataSourceItems;
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                  style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}


@end
