//
//  SMTTableDataSource.m
//  FanPian
//
//  Created by sa.xiong on 16/2/1.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTTableDataSource.h"
#import "SMTBeOnShowCell.h"

@interface SMTTableDataSource()
@property (nonatomic, copy) NSString *cellClassName;
@end

@implementation SMTTableDataSource

- (id)initWithDataItems:(NSMutableArray *)dataItems cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(TableViewCellConfigureBlock)cellConfigureBlock {
    if (self = [super init]) {
        self.dataItems = dataItems;
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = cellConfigureBlock;
    }
    return self;
}

- (id)initWithDataItems:(NSMutableArray *)dataItems cellClassName:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(TableViewCellConfigureBlock)cellConfigureBlock {
    if (self = [super init]) {
        self.dataItems = dataItems;
        self.cellClassName = cellClassName;
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
    
//    Class CellClass = NSClassFromString(self.cellClassName);
//    CellClass *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
//
//id myObj = [[NSClassFromString(self.cellClassName) alloc] init];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    id item = [self itemAtIndexPath:indexPath];
    self.cellConfigureBlock(cell,item);
    return cell;
}


@end
