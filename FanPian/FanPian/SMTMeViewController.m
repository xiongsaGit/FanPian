//
//  SMTMeViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/15.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMeViewController.h"
#import "SMTImageLabelView.h"


@interface SMTMeViewController ()

@end

@implementation SMTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
   
   
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"leftMenu" ofType:@"plist"];
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    self.arrayDataSource.items = data;
    [self.tableView reloadData];
    
    
    [self addTableViewHeader];
}

- (void)addTableViewHeader {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    headerView.backgroundColor = [UIColor cyanColor];

    SMTImageLabelView *liked = [[SMTImageLabelView alloc] initWithFrame:CGRectMake(CGRectGetWidth(headerView.frame)/4, 0, CGRectGetWidth(headerView.frame)/4, CGRectGetHeight(headerView.frame)/2) type:ImageLabelTypeImageLeft block:^{
        
    }];
    [liked configureImageName:@"liked" labelTitle:@"想看"];
    liked.centerY = headerView.centerY;
    
    
    SMTImageLabelView *want = [[SMTImageLabelView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(liked.frame), 0, CGRectGetWidth(headerView.frame)/2, CGRectGetHeight(headerView.frame)) type:ImageLabelTypeImageLeft block:^{
        
    }];
    want.backgroundColor = [UIColor blueColor];
    [want configureImageName:@"love_selected" labelTitle:@"看过"];
    
    [headerView addSubview:liked];
    [headerView addSubview:want];
    self.tableView.tableHeaderView = headerView;

    self.tableView.sectionHeaderHeight = 20;
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
