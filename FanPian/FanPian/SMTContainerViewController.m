//
//  SMTContainerViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/15.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTContainerViewController.h"

#import "SMTMainViewController.h"
#import "SMTMeViewController.h"
#import "SMTFindViewController.h"

#import "SMTScrollView.h"
#import "SMTNavTitleView.h"


@interface SMTContainerViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) SMTMeViewController *MeVC;
@property (nonatomic, strong) SMTFindViewController *FindVC;
@property (nonatomic, strong) SMTMainViewController *mainVC;
@property (nonatomic, strong) SMTScrollView *scrollView;
@end
@implementation SMTContainerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor clearColor];
    [self setupNavItems];
    [self setupNavView];
    
    
    [self setupScrollView];
}

- (void)setupScrollView {
    
    [self.view addSubview:self.scrollView];

    self.MeVC = [[SMTMeViewController alloc] init];
    self.MeVC.title = @"我的";
    
    self.mainVC = [[SMTMainViewController alloc] init];
    
    self.mainVC.title = @"推荐";
    
    self.FindVC = [[SMTFindViewController alloc] init];
    
    self.FindVC.title = @"发现";
    
    _scrollView.viewsArray = [NSArray arrayWithObjects:self.MeVC.view,self.mainVC.view,self.FindVC.view, nil];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.scrollView.viewsArray.count, SCREEN_HEIGHT);
    
//    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, PHONE_NAVIGATIONBAR_IOS7_HEIGHT) animated:YES];
    [self clickItemWithIndex:1];
}

- (void)leftBarButtonItemClick { }

- (void)rightBarButtonItemClick {
    
}


- (void)clickItemWithIndex:(NSInteger)index {
    
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
    
    // 刷新状态
    SMTNavTitleView *navTitleView = (SMTNavTitleView *)self.navigationItem.titleView;
    [navTitleView selectItem:index];
}

- (void)setupNavView {
    
    __weak typeof(self)weakSelf = self;
    SMTNavTitleView *navTitleView = [[SMTNavTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-120, 40) items:@[@"我的",@"推荐",@"发现"] clickBlock:^(NSInteger itemTag) {
        [weakSelf clickItemWithIndex:itemTag];
    }];
    self.navigationItem.titleView = navTitleView;
}

- (void)setupNavItems {
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *leftImage = [UIImage imageNamed:@"user"];
    leftItem.frame = CGRectMake(0, 0, leftImage.size.width, leftImage.size.height);
    [leftItem setBackgroundImage:leftImage forState:UIControlStateNormal];
    
    [leftItem addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightImage = [UIImage imageNamed:@"menu"];
    [rightItem setBackgroundImage:rightImage forState:UIControlStateNormal];
    
    rightItem.frame = CGRectMake(0, 0, rightImage.size.width, rightImage.size.height);
    [rightItem addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
}

- (SMTScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[SMTScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.delegate = self;
    }
    return _scrollView;
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