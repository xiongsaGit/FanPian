//
//  SMTCollectionViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTCollectionViewController.h"
#import "SMTShowViewController.h"

#import "SMTCollectionCell.h"

#import "SMTCollectionRequest.h"
#import "SMTCollectionDataModel.h"
@interface SMTCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceItems;

@end

@implementation SMTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"影单";
    
    self.dataSourceItems = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    

    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-PHONE_NAVIGATIONBAR_IOS7_HEIGHT);
    [self showDifferentListWithItemTag:1];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SMTCollectionListModel *model = self.dataSourceItems[indexPath.section];
    SMTShowViewController *viewCtrl = [[SMTShowViewController alloc] initWithType:MovieTypeFromCollection title:model.name ctid:model.ctid];
    
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceItems.count;
}

- (void)showDifferentListWithItemTag:(NSInteger)itemTag {
    
    SMTCollectionRequest *request = [[SMTCollectionRequest alloc] initWithPage:[NSNumber numberWithInteger:itemTag]];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;
        
        SMTCollectionDataModel *mode = [[SMTCollectionDataModel alloc] initWithString:request.responseString error:&err];
        
        self.dataSourceItems = [NSMutableArray arrayWithArray:mode.data.list];
        
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightOfCellAtIndexPath:indexPath];
}


- (CGFloat)heightOfCellAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat result;
    
    SMTCollectionListModel *model = self.dataSourceItems[indexPath.section];
    
    CGSize boundingSize = CGSizeMake(SCREEN_WIDTH-2*kEdge, 0);
    
    CGSize subjectSize = [self.view sizeWithText:model.name boundingSize:boundingSize font:kFontOfSize(15)];
    CGSize introSize = [self.view sizeWithText:model.desc boundingSize:boundingSize font:kFontOfSize(15)];
    
    result = SCREEN_WIDTH*0.6+kEdge*1.5+subjectSize.height+1.5*kEdge+introSize.height+kEdge;
    
    return result;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kEdge)];
    footer.backgroundColor = UIColorFromRGB(0xf2f2f2);
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    SMTCollectionCell *cell = (SMTCollectionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SMTCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell configureCellData:self.dataSourceItems[indexPath.section]];
  
    return cell;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;_tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = kEdge;
    }
    return _tableView;
}



@end
