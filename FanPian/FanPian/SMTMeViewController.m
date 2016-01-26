//
//  SMTMeViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/15.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMeViewController.h"
#import "SMTFocusViewController.h"
#import "SMTWantViewController.h"
#import "SMTHadWatchViewController.h"
#import "SMTImageLabelView.h"
#import "SMTFooter.h"

@interface SMTMeViewController ()<UITableViewDelegate>
@property (nonatomic, strong) SMTFooter *subFooter;
@end

@implementation SMTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    
    self.tableView.backgroundColor = [UIColor clearColor];
   
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"leftMenu" ofType:@"plist"];
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    self.arrayDataSource.items = data;
    [self.tableView reloadData];
    
    
    [self addTableViewHeader];
    [self addTableViewFooter];
    [self.subFooter configureTitleLabel:@"关注的影单"];
    [self.subFooter configureDetailLabel:@"0"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)addTableViewHeader {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    UIView *subHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    subHeader.backgroundColor = UIColorFromRGB(0xffffff);
    
    __weak typeof(self)weakSelf = self;
    SMTImageLabelView *liked = [[SMTImageLabelView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headerView.frame)/2, CGRectGetHeight(headerView.frame)) type:ImageLabelTypeImageLeft block:^{
        
        SMTWantViewController *viewCtrl = [[SMTWantViewController alloc] init];
        [[weakSelf viewController].navigationController pushViewController:viewCtrl animated:YES];
        
    }];
    [liked configureImageName:@"likeSelect" labelTitle:@"想看"];
    [subHeader addSubview:liked];
    
    SMTImageLabelView *want = [[SMTImageLabelView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(liked.frame), 0, CGRectGetWidth(headerView.frame)/2, CGRectGetHeight(headerView.frame)) type:ImageLabelTypeImageLeft block:^{
        SMTHadWatchViewController *viewCtrl = [[SMTHadWatchViewController alloc] init];
        [[weakSelf viewController].navigationController pushViewController:viewCtrl animated:YES];
        
    }];
    [want configureImageName:@"love_selected" labelTitle:@"看过"];
    [subHeader addSubview:want];
    
    UILabel *sep = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(subHeader.frame)/2, 0, 1, CGRectGetHeight(subHeader.frame))];
    sep.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [subHeader addSubview:sep];
    
    UILabel *horizonSep = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(subHeader.frame)-1, CGRectGetWidth(subHeader.frame), 1)];
    horizonSep.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [subHeader addSubview:horizonSep];
    [headerView addSubview:subHeader];
    self.tableView.tableHeaderView = headerView;

}

- (void)addTableViewFooter {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.subFooter.frame = CGRectMake(0, 10, SCREEN_WIDTH, 40);
    footer.backgroundColor = [UIColor clearColor];
    [footer addSubview:self.subFooter];
    self.tableView.tableFooterView = footer;
}

- (SMTFooter *)subFooter {
    if (!_subFooter) {
        __weak typeof(self)weakSelf = self;
        _subFooter = [[SMTFooter alloc] initWithClickBlock:^{
            SMTFocusViewController *viewCtrl = [[SMTFocusViewController alloc] init];
            [[weakSelf viewController].navigationController pushViewController:viewCtrl animated:YES];
        }];
        _subFooter.backgroundColor = UIColorFromRGB(0xffffff);

    }
    return _subFooter;
}

- (UIViewController*)viewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
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
