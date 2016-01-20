//
//  RHCArrayDataSource.m
//  Renrenlicai_ios_instalment
//
//  Created by sa.xiong on 15/12/29.
//  Copyright © 2015年 renren. All rights reserved.
//

#import "RHCArrayDataSource.h"

@implementation RHCArrayDataSource


- (id)initWithItems:(NSMutableArray *)aItems
     cellIdentifier:(NSString *)aCellIdentifier
     configureBlock:(TableViewCellConfigureBlock)aConfigureBlock {
    
    if (self = [super init]) {
        self.items = aItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureBlock = aConfigureBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
        UILabel *separatorLine = [[UILabel alloc] initWithFrame:CGRectMake(55.0f, cell.frame.size.height - 1.0f, cell.frame.size.width-55, 1.0f)];
        separatorLine.backgroundColor = UIColorFromRGB(0xf3f3f3);
        separatorLine.tag = 4;
        [cell.contentView addSubview:separatorLine];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Setup default cell setttings.
    UILabel *separatorLine = (UILabel *)[cell viewWithTag:4];
    if (indexPath.row == self.items.count-1) {
        separatorLine.hidden = YES;
    }else
        separatorLine.hidden = NO;

    
    id item = [self itemAtIndexPath:indexPath];
    self.configureBlock(cell,item);
    return cell;
}



@end
