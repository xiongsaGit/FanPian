//
//  SMTSalonDetailViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/27.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTSalonDetailViewController.h"

#import "SMTSalonDetailHeader.h"
#import "SMTSalonDetailCell.h"


#import "SMTCollectionTypeRequest.h"

#import "SMTSalonDetailDataModel.h"
#import "SMTSalonDetailListModel.h"
@interface SMTSalonDetailViewController()<UITableViewDataSource,UITableViewDelegate,SalonDetailHeaderDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataItems;
@property (nonatomic, strong) SMTSalonDetailHeader *headerView;
@property (nonatomic, copy) NSString *ctid;
@property (nonatomic, assign) NSInteger curPageNum;

@end

@implementation SMTSalonDetailViewController

- (id)initWithCtid:(NSString *)ctid {
    if (self = [super init]) {
        self.ctid = ctid;
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.curPageNum = 1;
    self.dataItems = [NSMutableArray array];
//    [self.view addSubview:self.tableView];
//    [self addTableViewHeader];
    
    [self.view addSubview:self.headerView];
    [self defaultRequest];

    
}


- (void)defaultRequest {
    SMTCollectionTypeRequest *request = [[SMTCollectionTypeRequest alloc] initWithType:CollectionOrSalonTypeSalon page:@(self.curPageNum) ctid:self.ctid];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSError *error = nil;
        SMTSalonDetailDataModel *model = [[SMTSalonDetailDataModel alloc] initWithString:request.responseString error:&error];
        [self.headerView configureData:model.data];

        
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void)refreshHeightOfHeader:(CGFloat)heightOfHeader {
    CGRect headerRect = self.headerView.frame;
    headerRect.size.height = heightOfHeader;
    self.headerView.frame = headerRect;

}

- (void)setDataItems:(NSMutableArray *)dataItems {
    _dataItems = dataItems;
    
    [self.tableView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), SCREEN_HEIGHT-PHONE_NAVIGATIONBAR_IOS7_HEIGHT)];
}

- (void)addTableViewHeader {
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 170);
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
    SMTSalonDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[SMTSalonDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.size = CGSizeMake(SCREEN_WIDTH, 80);
    SMTSalonDetailListModel *listModel = self.dataItems[indexPath.row];
    [cell configureData:listModel];
    
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
        _tableView.rowHeight = 80.0f;
    }
    return _tableView;
}

- (SMTSalonDetailHeader *)headerView {
    if (!_headerView) {
        _headerView = [[SMTSalonDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _headerView.headerDelegate = self;
    }
    return _headerView;
}

@end
