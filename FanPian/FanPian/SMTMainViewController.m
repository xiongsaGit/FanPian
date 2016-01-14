//
//  SMTMainViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/14.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMainViewController.h"
#import "SMTNavTitleView.h"

@interface SMTMainViewController ()

@end

@implementation SMTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavItems];
    [self setupNavView];
}

- (void)leftBarButtonItemClick { }

- (void)rightBarButtonItemClick {

}

- (void)scrollToIndex:(NSInteger)index {

}


- (void)setupNavView {
    
    __weak typeof(self)weakSelf = self;
    SMTNavTitleView *navTitleView = [[SMTNavTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-120, 40) items:[NSArray arrayWithObjects:@"我的", @"推荐",@"发现",nil] clickBlock:^(NSInteger itemTag) {
        [weakSelf scrollToIndex:itemTag];
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
