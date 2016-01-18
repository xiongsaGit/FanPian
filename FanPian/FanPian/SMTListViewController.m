//
//  SMTListViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/1/14.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTListViewController.h"

@interface SMTListViewController ()<UITableViewDelegate>

@end

@implementation SMTListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mutArray = [NSMutableArray array];
    [self setupTableView];
}

- (void)setupTableView {
    self.configureCell = ^(id cell ,id item) {
        UITableViewCell *resultCell = (UITableViewCell *)cell;
        NSDictionary *dict = (NSDictionary *)item;
        resultCell.textLabel.text = dict[@"titleContent"];
        resultCell.imageView.image = [UIImage imageNamed:dict[@"imageName"]];
    };
    self.arrayDataSource = [[RHCArrayDataSource alloc] initWithItems:self.mutArray cellIdentifier:@"cellIdentifier" configureBlock:self.configureCell];
    self.tableView.dataSource = self.arrayDataSource;
    [self.view addSubview:self.tableView];
}


#pragma mark - tableView

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ObjectInfoModal *info = [self.marketArrayDataSource.items objectAtIndex:indexPath.row];
//    RHCProductViewController *productViewCtrl = [[RHCProductViewController alloc]init];
//    productViewCtrl.objectId = info.objectId;
//    [self.navigationController pushViewController:productViewCtrl animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                    style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 44;
    }
    return _tableView;
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
