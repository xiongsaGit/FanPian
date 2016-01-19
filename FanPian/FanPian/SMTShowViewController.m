//
//  SMTShowViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTShowViewController.h"
#import "SMTNavTitleView.h"

#import "SMTBeOnShowRequest.h"
#import "SMTBeOnShowModel.h"
@interface SMTShowViewController ()

@end

@implementation SMTShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"上映";
    
    __weak typeof(self)weakSelf = self;
    SMTNavTitleView *titleView = [[SMTNavTitleView alloc] initWithFrame:CGRectMake(0, PHONE_NAVIGATIONBAR_IOS7_HEIGHT, SCREEN_WIDTH, 40) items:@[@"正在上映",@"即将上映"] clickBlock:^(NSInteger itemTag) {
        [weakSelf showDifferentListWithItemTag:itemTag];
    }];
    [titleView selectItem:0];
    [self.view addSubview:titleView];
    
    [self showDifferentListWithItemTag:0];
}

- (void)showDifferentListWithItemTag:(NSInteger)itemTag {
    
    SMTBeOnShowRequest *request = [[SMTBeOnShowRequest alloc] initWithType:@1 page:@1];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSError* err = nil;

        SMTBeOnShowModel *model = [[SMTBeOnShowModel alloc] initWithString:request.responseString error:&err];
        NSLog(@"model:%@",model.fromhash);
        
    } failure:^(YTKBaseRequest *request) {
        
    }];
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
