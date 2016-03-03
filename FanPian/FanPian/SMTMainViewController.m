//
//  SMTMainViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/14.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMainViewController.h"
#import "SMTMovieExploreRequest.h"
#import "SMTImageTitleDescCell.h"
#import "SMTMovieExplorerDataModel.h"
#import "SMTThreadgalleryCell.h"
#import "SMTMLChannelCell.h"
#import "SMTMLMovielinesCell.h"
#import "SMTMainHeader.h"

typedef NS_ENUM(NSInteger,MainTableViewRequestType) {
    MainTableViewRequestTypeDefault,
    MainTableViewRequestTypeRefresh,
    MainTableViewRequestTypeLoadMore,
};

@interface SMTMainViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) SMTMainHeader *headerView;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, copy) NSString *curPdateline;
@property (nonatomic, assign) MainTableViewRequestType requestType;
@end

@implementation SMTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.curPage = 1;
    self.requestType = MainTableViewRequestTypeDefault;
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
    [self addHeaderView];
    [self requestMainPageDataWithPdataline:@"0" AtPageNum:self.curPage];
}

- (void)requestMainPageDataWithPdataline:(NSString *)pdateline AtPageNum:(NSInteger)pageNum {
    
    SMTMovieExploreRequest *request = [[SMTMovieExploreRequest alloc] initWithPage:@(pageNum) pdateline:pdateline];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;
        SMTMovieExplorerDataModel *model = [[SMTMovieExplorerDataModel alloc] initWithString:request.responseString error:&err];
        
        if (self.requestType == MainTableViewRequestTypeDefault || self.requestType == MainTableViewRequestTypeRefresh) {
            [self.dataArray removeAllObjects];
            self.dataArray = [NSMutableArray arrayWithArray:model.data.list];
            self.curPage = 1;
        }else {
            [self.dataArray addObjectsFromArray:model.data.list];
        }
        
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void)refreshDataInTableView {
    self.requestType = MainTableViewRequestTypeRefresh;
    [self requestMainPageDataWithPdataline:@"0" AtPageNum:self.curPage];
}

- (void)loadMoreDataInTableView {
    self.curPage ++;

    self.requestType = MainTableViewRequestTypeLoadMore;
    [self requestMainPageDataWithPdataline:self.curPdateline AtPageNum:self.curPage];
}

- (void)addHeaderView {
    self.headerView = [[SMTMainHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableView.tableHeaderView = self.headerView;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"mainlist" ofType:@"plist"];
    self.headerView.operateItems = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMTMEListItemModel *itemModel = self.dataArray[indexPath.section];
    NSString *type = itemModel.type;
    if ([type isEqualToString:@"threadgallery"]) {
        
        SMTThreadgalleryCell *cell = (SMTThreadgalleryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }else if ([type isEqualToString:@"movielines"]) {
        SMTMLMovielinesCell *cell = (SMTMLMovielinesCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }else if ([type isEqualToString:@"channel"]) {
        SMTMLChannelCell *cell = (SMTMLChannelCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }else {

        SMTImageTitleDescCell *cell = (SMTImageTitleDescCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.cellHeight;
    }//threadgallery movielines  channel
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMTMEListItemModel *itemModel = self.dataArray[indexPath.section];
    if ([itemModel.type isEqualToString:@"threadgallery"]) {
        
        static NSString *identifier = @"threadgallery";
        SMTThreadgalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (cell==nil)
        {
            cell = [[SMTThreadgalleryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell configureGalleryCellData:itemModel];
        
        return cell;
    }else if ([itemModel.type isEqualToString:@"channel"]) {
        static NSString *identifier = @"channel";
        SMTMLChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (cell==nil)
        {
            cell = [[SMTMLChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell configureCellForData:itemModel];
        
        return cell;

    }else if ([itemModel.type isEqualToString:@"movielines"]) {
        static NSString *identifier = @"movielines";
        SMTMLMovielinesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (cell==nil)
        {
            cell = [[SMTMLMovielinesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell configureCellForData:itemModel];
        
        return cell;
    }else {
        static NSString *identifier = @"cellId";
        SMTImageTitleDescCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell==nil)
        {
            cell = [[SMTImageTitleDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 18)];
            typeLabel.backgroundColor = [SMTRandomColor randomColor];
            typeLabel.tag = 10001;
            typeLabel.font = kFontOfSize(11);
            typeLabel.textColor = [UIColor whiteColor];
            typeLabel.textAlignment = NSTextAlignmentCenter;
            typeLabel.adjustsFontSizeToFitWidth = YES;
            [cell.contentView addSubview:typeLabel];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *lbl = [cell.contentView viewWithTag:10001];
        if ([self typeLabelTitleWithType:itemModel.type]==nil) {
            lbl.hidden = YES;
        }else {
            lbl.text = [self typeLabelTitleWithType:itemModel.type];
            lbl.hidden = NO;
        }
        BOOL lookMore = [[self movieTypeDataWithType:itemModel.type][@"hasmore"]boolValue];
        
        [cell configureCellData:itemModel.itemdata withLookMore:lookMore withType:itemModel.type];
        [cell hideLookButton:![[self movieTypeDataWithType:itemModel.type][@"hasmore"]boolValue]];

       
        return cell;
    }
}

- (NSDictionary *)movieTypeDataWithType:(NSString *)type {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"movietype" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    for (NSDictionary *item in data) {
        if ([item[@"type"] isEqualToString:type]) {
            return item;
        }
    }
    return nil;
}

- (NSString *)typeLabelTitleWithType:(NSString *)type {

    NSDictionary *item =  [self movieTypeDataWithType:type];
    NSString *content = nil;
    if ([item[@"needshow"] boolValue]) {
        content = item[@"content"];
        NSLog(@"content:%@",content);
    }
    return content;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSIndexPath *
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    footer.backgroundColor = UIColorFromRGB(0xefeff4);
    return footer;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionFooterHeight = 10;
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataInTableView)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataInTableView)];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
