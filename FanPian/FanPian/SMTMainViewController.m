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

#import "SMTMainHeader.h"
@interface SMTMainViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) SMTMainHeader *headerView;
@property (nonatomic, assign) NSInteger curPage;

@end

@implementation SMTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    
    [self addHeaderView];
    [self requestMainPageDataWithPdataline:@"0"];
}

- (void)requestMainPageDataWithPdataline:(NSString *)pdateline {
    SMTMovieExploreRequest *request = [[SMTMovieExploreRequest alloc] initWithPage:@(self.curPage) pdateline:pdateline];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;
        SMTMovieExplorerDataModel *model = [[SMTMovieExplorerDataModel alloc] initWithString:request.responseString error:&err];
         self.dataArray = [NSMutableArray arrayWithArray:model.data.list];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


- (void)addHeaderView {
    self.headerView = [[SMTMainHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableView.tableHeaderView = self.headerView;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"mainlist" ofType:@"plist"];
    self.headerView.operateItems = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMTMEListItemModel *itemModel = self.dataArray[indexPath.row];
    NSDictionary *item = [self movieTypeDataWithType:itemModel.type];
    if ([item[@"hasmore"] boolValue]) {
        return 300+40;
    }else
        return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellId";
    SMTImageTitleDescCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    SMTMEListItemModel *itemModel = self.dataArray[indexPath.row];

    if (cell==nil)
    {
        cell = [[SMTImageTitleDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
        typeLabel.backgroundColor = [SMTRandomColor randomColor];
        typeLabel.tag = 10001;
        [cell.contentView addSubview:typeLabel];
        
        if ([[self movieTypeDataWithType:itemModel.type][@"hasmore"]boolValue]) {
            // 添加 查看 按钮
            
            UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [lookBtn setFrame:CGRectMake((SCREEN_WIDTH-100)/2, CGRectGetHeight(cell.contentView.frame)-40, 100, 40)];
            lookBtn.layer.borderColor = [UIColorFromRGB(0xbf5758) CGColor];
            lookBtn.layer.borderWidth = 1;
            [lookBtn setTitle:@"查看" forState:UIControlStateNormal];
            [lookBtn setTitleColor:UIColorFromRGB(0xbf5758) forState:UIControlStateNormal];
            [cell.contentView  addSubview:lookBtn];
        }
    }
    按钮过大，标签文本居中

    UILabel *lbl = [cell.contentView viewWithTag:10001];
    if ([self typeLabelTitleWithType:itemModel.type]==nil) {
        lbl.hidden = YES;
    }else {
        lbl.text = [self typeLabelTitleWithType:itemModel.type];
        lbl.hidden = NO;
    }
    
    [cell configureCellData:itemModel.itemdata];
    return cell;
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
    }
    return content;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSIndexPath *
}


- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
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
