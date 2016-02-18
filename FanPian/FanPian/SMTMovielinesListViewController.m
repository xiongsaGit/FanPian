//
//  SMTMovielinesListViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/2/1.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMovielinesListViewController.h"
#import "SMTBeOnShowCell.h"

#import "SMTBeOnShowRequest.h"
#import "SMTBeOnShowDataModel.h"


static NSString *const CellIdentifier = @"cellIdentifier";
@interface SMTMovielinesListViewController()

@end

@implementation SMTMovielinesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)setupTableView {
    TableViewCellConfigureBlock configureBlock = ^(SMTBeOnShowCell *cell ,SMTBeOnShowListModel *item){
        [cell configureCellData:item];
    };
    
    self.tableDataSource = [[SMTTableDataSource alloc] initWithDataItems:self.dataItems cellIdentifier:CellIdentifier cellConfigureBlock:configureBlock];
    
    self.tableView.dataSource = self.tableDataSource;
    self.itemHeight = 320;
}

- (void)defaultRequestData {
    SMTBeOnShowRequest *request = [[SMTBeOnShowRequest alloc] initWithType:@(1) page:@(1)];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;
        
        SMTBeOnShowDataModel *mode = [[SMTBeOnShowDataModel alloc] initWithString:request.responseString error:&err];
        self.dataItems = [NSMutableArray arrayWithArray:mode.data.list];
        self.tableDataSource.dataItems = self.dataItems;
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

@end
