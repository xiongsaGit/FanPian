//
//  SMTFindViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/15.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTFindViewController.h"

@interface SMTFindViewController ()

@end

@implementation SMTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"rightMenu" ofType:@"plist"];
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    self.arrayDataSource.items = data;
    [self.tableView reloadData];
    
    
    [self addTableViewHeader];
}

- (void)addTableViewHeader {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    headerView.backgroundColor = [UIColor orangeColor];
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
