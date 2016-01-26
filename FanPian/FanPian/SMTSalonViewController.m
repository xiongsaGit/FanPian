//
//  SMTSalonViewController.m
//  LabelOnImageView
//
//  Created by sa.xiong on 16/1/25.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTSalonViewController.h"
#import "SMTHeaderView.h"

#import "SMTSalonRequest.h"
#import "SMTSalonDataModel.h"

@interface SMTSalonViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataItems;
@property (nonatomic, strong) SMTHeaderView *headerView;
@property (nonatomic, assign) NSInteger curPageNum;
@end

@implementation SMTSalonViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.curPageNum = 1;
    self.dataItems = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self addTableViewHeader];
    
    [self requestSalonData];
}

- (void)requestSalonData {
    SMTSalonRequest *request = [[SMTSalonRequest alloc] initWithPage:@(self.curPageNum)];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError *error = nil;
        SMTSalonDataModel *model = [[SMTSalonDataModel alloc] initWithString:request.responseString error:&error];
        self.dataItems = [NSMutableArray arrayWithArray:model.data.list];
        
        [self makeTableViewDataWithList:model.data.list];
        
        [self.tableView reloadData];
        
        
        
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void)makeTableViewDataWithList:(NSArray *)list {
   
    if (list.count > 2) {
       NSArray *headerDataList = [NSArray arrayWithObjects:list[0],list[1], nil];
        [self.headerView loadDataArray:headerDataList];
        [self.dataItems removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
    }
}

- (void)setDataItems:(NSMutableArray *)dataItems {
    _dataItems = dataItems;
    
//    CGFloat height = 170+80*dataItems.count)>SCREEN_HEIGHT-PHONE_NAVIGATIONBAR_IOS7_HEIGHT?(SCREEN_HEIGHT-PHONE_NAVIGATIONBAR_IOS7_HEIGHT)
    [self.tableView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), SCREEN_HEIGHT-PHONE_NAVIGATIONBAR_IOS7_HEIGHT)];
}

- (void)addTableViewHeader {
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 170);
    self.headerView.backgroundColor = [UIColor greenColor];
    self.tableView.tableHeaderView = self.headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    SMTSalonListModel *listModel = self.dataItems[indexPath.row];
    cell.textLabel.text = listModel.name;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,listModel.icon]] placeholderImage:nil options:SDWebImageProgressiveDownload];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSIndexPath *
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50.0f;
    }
    return _tableView;
}

- (void)click:(NSInteger)itemTag {
    NSLog(@"click :%d",(int)itemTag);
}

- (SMTHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self)weakSelf = self;
        _headerView = [[SMTHeaderView alloc] initWithItemClickBlock:^(NSInteger itemTag) {
            [weakSelf click:itemTag];
        }];
    }
    return _headerView;
}

@end
