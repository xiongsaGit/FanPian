//
//  SMTShortMovieViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTShortMovieViewController.h"
#import "SMTShortMovieCell.h"

#import "SMTBeOnShowRequest.h"
#import "SMTShortMovieDataModel.h"

#import "SMTShortMovieRequest.h"

@interface SMTShortMovieViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceItems;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, strong) UIImageView *animateImageView;
@property (nonatomic, assign) CGSize imageSize;

@end
@implementation SMTShortMovieViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   self.title = @"短片";
    self.curPage = 1;
    self.isChecked = NO;
    
    self.dataSourceItems = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-PHONE_NAVIGATIONBAR_IOS7_HEIGHT);
    [self requestDataByPageNum:self.curPage];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceItems.count;
}

- (void)requestDataByPageNum:(NSInteger)pageNum {
    
    SMTShortMovieRequest *request = [[SMTShortMovieRequest alloc] initWithPage:[NSNumber numberWithInteger:pageNum]];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;
        
        SMTShortMovieDataModel *model = [[SMTShortMovieDataModel alloc] initWithString:request.responseString error:&err];
        
        self.dataSourceItems = [NSMutableArray arrayWithArray:model.data.list];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

//    [self.dataSourceItems objectAtIndex:indexPath.section];
    return [self heightOfCellAtIndexPath:indexPath];
}

- (CGFloat)heightOfCellAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat result;
    
    SMTShortMovieListModel *model = self.dataSourceItems[indexPath.section];
    
    CGSize boundingSize = CGSizeMake(SCREEN_WIDTH-2*kEdge, 0);
    
    CGSize subjectSize = [self.view sizeWithText:model.subject boundingSize:boundingSize font:kFontOfSize(15)];
    CGSize introSize = [self.view sizeWithText:model.intro boundingSize:boundingSize font:kFontOfSize(15)];

    result = SCREEN_WIDTH*[model.height floatValue]/[model.width floatValue]+kEdge+subjectSize.height+1.5*kEdge+introSize.height+40;
    
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    SMTShortMovieCell *cell = (SMTShortMovieCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SMTShortMovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self)weakSelf = self;
        cell.itemBlock = ^(SMTShortMovieCell *cell ,NSInteger itemTag){
            weakSelf.isChecked = !weakSelf.isChecked;
            [weakSelf clickItemInCell:cell itemTag:itemTag ];
        };
    }
    
    [cell configureCellData:self.dataSourceItems[indexPath.section]];

    return cell;
}

- (void)clickItemInCell:(SMTShortMovieCell *)cell itemTag:(NSInteger)itemTag {
    
    if (itemTag == 0) {
        if (!_animateImageView) {
            [self.view addSubview:self.animateImageView];
        }
        [self animateWithState:self.isChecked];
        [cell configureBarViewAtItemTag:itemTag state:self.isChecked];
    }else if (itemTag == 1) {
        // 评论
        NSLog(@"评论");
    }else {
        NSLog(@"弹出操作表");
        // 弹出操作表
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = kEdge;
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

@end
