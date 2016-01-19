//
//  SMTFindViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/15.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTFindViewController.h"
#import "SMTImageLabelView.h"

#import "SMTShowViewController.h"


@interface SMTFindViewController ()<UITableViewDelegate>

@end

@implementation SMTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"rightMenu" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    self.arrayDataSource.items = data;
    [self.tableView reloadData];
    
    [self addTableViewHeader];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)clickToDifferentPageWithViewTag:(NSInteger )viewTag {
    switch (viewTag) {
        case 0:
        {
            SMTShowViewController *viewCtrl = [[SMTShowViewController alloc] init];

            [[self viewController].navigationController pushViewController:viewCtrl animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)addTableViewHeader {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    self.tableView.tableHeaderView = headerView;
    
    UIView *subHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    subHeader.backgroundColor = UIColorFromRGB(0xffffff);
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"rightHeaderList" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    CGFloat iconWidth = CGRectGetWidth(headerView.frame)/3;
    CGFloat iconHeight = CGRectGetHeight(headerView.frame)/2;
    
    __weak typeof(self)weakSelf = self;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j ++) {
            SMTImageLabelView *imageLabelView = [[SMTImageLabelView alloc] initWithFrame:CGRectMake(iconWidth*j, iconHeight*i, iconWidth, iconHeight) type:ImageLabelTypeImageOn];
            imageLabelView.tag = 3*i + j;
            imageLabelView.clickBlock = ^(){
                [weakSelf clickToDifferentPageWithViewTag:3*i+j];
            };
            
            NSDictionary *dict = data[3*i+j];
            [imageLabelView configureImageName:dict[@"imageName"] labelTitle:dict[@"titleContent"]];
            [subHeader addSubview:imageLabelView];
        }
    }

    UILabel *sepLine1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(subHeader.frame)/3, 0, 1, CGRectGetHeight(subHeader.frame))];
    sepLine1.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [subHeader addSubview:sepLine1];
    
    UILabel *sepLine2 = [[UILabel alloc] initWithFrame:CGRectMake(2*CGRectGetWidth(subHeader.frame)/3, 0, 1, CGRectGetHeight(subHeader.frame))];
    sepLine2.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [subHeader addSubview:sepLine2];
    
    UILabel *horizonSep = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(subHeader.frame)/2, CGRectGetWidth(subHeader.frame), 1)];
    horizonSep.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [subHeader addSubview:horizonSep];
    
    [headerView addSubview:subHeader];
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
