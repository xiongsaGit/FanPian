//
//  SMTShowViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTShowViewController.h"
#import "SMTNavTitleView.h"
#import "SMTBeOnShowCell.h"

#import "SMTBeOnShowRequest.h"
#import "SMTBeOnShowModel.h"
#import "SMTBeOnShowDataModel.h"
@interface SMTShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceItems;

@end

@implementation SMTShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"上映";
    
    self.dataSourceItems = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
    __weak typeof(self)weakSelf = self;
    SMTNavTitleView *titleView = [[SMTNavTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) items:@[@"正在上映",@"即将上映"] clickBlock:^(NSInteger itemTag) {
        [weakSelf showDifferentListWithItemTag:itemTag];
    }];
    [titleView selectItem:0];
    [self.view addSubview:titleView];
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(titleView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(titleView.frame));
    [self showDifferentListWithItemTag:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceItems.count;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;_tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}


- (void)showDifferentListWithItemTag:(NSInteger)itemTag {
    
    SMTBeOnShowRequest *request = [[SMTBeOnShowRequest alloc] initWithType:@1 page:@1];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;

        SMTBeOnShowDataModel *mode = [[SMTBeOnShowDataModel alloc] initWithString:request.responseString error:&err];
        
        self.dataSourceItems = [NSMutableArray arrayWithArray:mode.data.list];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    SMTBeOnShowCell *cell = (SMTBeOnShowCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SMTBeOnShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        UILabel *separatorLine = [[UILabel alloc] initWithFrame:CGRectMake(55.0f, cell.frame.size.height - 1.0f, cell.frame.size.width-55, 1.0f)];
//        separatorLine.backgroundColor = UIColorFromRGB(0xf3f3f3);
//        separatorLine.tag = 4;
//        [cell.contentView addSubview:separatorLine];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Setup default cell setttings.
//    UILabel *separatorLine = (UILabel *)[cell viewWithTag:4];
//    if (indexPath.row == self.dataSourceItems.count-1) {
//        separatorLine.hidden = YES;
//    }else
//        separatorLine.hidden = NO;
    
    [cell configureCellData:self.dataSourceItems[indexPath.row]];
//    if (indexPath.row%2==0) {
//        cell.contentView.backgroundColor = [UIColor blueColor];
//    }
    return cell;
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
