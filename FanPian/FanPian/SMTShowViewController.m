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
#import "UIPopoverListView.h"
#import "SMTBeOnShowRequest.h"
#import "SMTBeOnShowDataModel.h"

#import "SMTCollectionTypeRequest.h"
#import "SMTCollectionTypeDataModel.h"

@interface SMTShowViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverListViewDataSource,UIPopoverListViewDelegate>
@property (nonatomic, assign) MovieTypeFrom movieType;
@property (nonatomic, copy) NSString *ctid;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceItems;
@property (nonatomic, strong) UIPopoverListView *listView;
@property (nonatomic, strong) NSArray *listDataSource;
@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, strong) UIImageView *animateImageView;
@property (nonatomic, assign) CGSize imageSize;
@end

@implementation SMTShowViewController

- (id)initWithType:(MovieTypeFrom)type title:(NSString *)title ctid:(NSString *)ctid {
    if (self = [super init]) {
        self.movieType = type;
        self.title = title;
        self.ctid = ctid;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isChecked = NO;

    self.curPage = 1;
    
    // 影单详情 需要导航栏右侧添加分享按钮

    self.dataSourceItems = [NSMutableArray array];
    self.listView.listDataSource = [NSArray arrayWithObjects:@"加入影单",@"分享",@"取消", nil];
    [self.view addSubview:self.tableView];
    
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
    if (self.movieType == MovieTypeFromDefault) {
        __weak typeof(self)weakSelf = self;
        SMTNavTitleView *titleView = [[SMTNavTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) items:@[@"正在上映",@"即将上映"] clickBlock:^(NSInteger itemTag) {
            [weakSelf showDifferentListWithItemTag:itemTag];
        }];
        [titleView selectItem:0];
        [self.view addSubview:titleView];
        
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(titleView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(titleView.frame));
        [self requestListData];
    }else {
    
    
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-PHONE_NAVIGATIONBAR_IOS7_HEIGHT);
        [self requestListData];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceItems.count;
}

- (void)requestListData {
    if (self.movieType == MovieTypeFromDefault) {
        // 这个是默认请求
        [self showDifferentListWithItemTag:0];
    }else {
    
        SMTCollectionTypeRequest *request = [[SMTCollectionTypeRequest alloc] initWithType:CollectionOrSalonTypeCollection page:@(self.curPage) ctid:self.ctid];
        [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSError* err = nil;
            
            SMTCollectionTypeDataModel *mode = [[SMTCollectionTypeDataModel alloc] initWithString:request.responseString error:&err];
            
            self.dataSourceItems = [NSMutableArray arrayWithArray:mode.data.list];
            [self.tableView reloadData];
        } failure:^(YTKBaseRequest *request) {
            
        }];
    }
    
}

- (void)showDifferentListWithItemTag:(NSInteger)itemTag {
    
    SMTBeOnShowRequest *request = [[SMTBeOnShowRequest alloc] initWithType:@(itemTag+1) page:@(self.curPage)];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;

        SMTBeOnShowDataModel *mode = [[SMTBeOnShowDataModel alloc] initWithString:request.responseString error:&err];
        
        self.dataSourceItems = [NSMutableArray arrayWithArray:mode.data.list];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 360;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    SMTBeOnShowCell *cell = (SMTBeOnShowCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SMTBeOnShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self)weakSelf = self;
        cell.itemBlock = ^(SMTBeOnShowCell *cell ,NSInteger itemTag){
            weakSelf.isChecked = !weakSelf.isChecked;
            [weakSelf clickCell:cell itemTag:itemTag ];
        };
   
    }
    
    [cell configureCellData:self.dataSourceItems[indexPath.section]];

    return cell;
}



- (void)clickCell:(SMTBeOnShowCell *)cell itemTag:(NSInteger)itemTag {
    
    if (itemTag == 0) {
        if (!_animateImageView) {
            [self.view addSubview:self.animateImageView];
        }
        [self animateWithState:self.isChecked];
        
        [cell configureBarViewAtItemTag:itemTag state:self.isChecked];
    }else if (itemTag == 1) {
        NSLog(@"评论呢");
    }else {
        NSLog(@"哈哈");
        [self.listView show];
    }
}


- (void)animateWithState:(BOOL)isChecked {
    if (self.isChecked) {
        self.animateImageView.hidden = NO;
        self.animateImageView.alpha = 1;
        self.animateImageView.size = self.imageSize;
        [UIView animateWithDuration:.5 animations:^{
            CGRect rect = self.animateImageView.frame;
            rect.size = CGSizeMake(rect.size.width/3, rect.size.height/3);
            self.animateImageView.frame = rect;
            self.animateImageView.center = self.view.center;
            self.animateImageView.alpha = 0;
        } completion:^(BOOL finished) {
        }];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kEdge)];
    footer.backgroundColor = UIColorFromRGB(0xf2f2f2);
    return footer;
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
        _tableView.sectionFooterHeight = kEdge;
        _tableView.sectionHeaderHeight = 0;
    }
    return _tableView;
}

- (UIImageView *)animateImageView
{
    if (!_animateImageView)
    {
        UIImage *image = [UIImage imageNamed:@"likedAnimated"];
        _animateImageView = [[UIImageView alloc] initWithImage:image];
        _animateImageView.size = image.size;
        _animateImageView.center = self.view.center;
        self.imageSize = image.size;
        _animateImageView.alpha = 0;
    }
    return _animateImageView;
}

- (UIPopoverListView *)listView {
    if (!_listView) {
        _listView = [[UIPopoverListView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 32+44*3+10)];
        _listView.delegate = self;
        _listView.datasource = self;
        _listView.listView.scrollEnabled = FALSE;
        [_listView setTitle:@"更多"];
    }
    return _listView;
}

- (NSInteger)numberOfSectionsInPopoverListView:(UIPopoverListView *)popoverListView {
    return 2;
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            cell.textLabel.text = @"加入影单";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"分享";
        }
    }else {
        cell.textLabel.text = @"取消";
    }
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else {
        return 1;
    }
    //    return 4;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, (int)indexPath.row);
    // your code here
}

//- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
//   heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60.0f;
//}


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
