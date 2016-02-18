//
//  SMTTableDataSource.m
//  FanPian
//
//  Created by sa.xiong on 16/2/1.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTTableDataSource.h"

@implementation SMTTableDataSource

- (id)initWithDataItems:(NSMutableArray *)dataItems cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(TableViewCellConfigureBlock)cellConfigureBlock {
    if (self = [super init]) {
        self.dataItems = dataItems;
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = cellConfigureBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataItems[indexPath.section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.cellConfigureBlock(cell,item);
    return cell;
}


@end
