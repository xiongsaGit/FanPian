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

#import "SMTTableDataSource.h"
static NSString *const CellIdentifier = @"cellIdentifier";
@interface SMTMovielinesListViewController()<UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataItems;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SMTTableDataSource *tableDataSource;

@property (nonatomic, assign) CGFloat itemHeight;

@end

@implementation SMTMovielinesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemHeight = 44.0f;
    self.dataItems = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    [self setupTableView];
    
    [self defaultRequestData];

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
