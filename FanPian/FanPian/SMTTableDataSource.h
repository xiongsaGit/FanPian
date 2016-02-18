//
//  SMTTableDataSource.h
//  FanPian
//
//  Created by sa.xiong on 16/2/1.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TableViewCellConfigureBlock)(id cell ,id item);

@interface SMTTableDataSource : NSObject<UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataItems;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock cellConfigureBlock;

- (id)initWithDataItems:(NSMutableArray *)dataItems
         cellIdentifier:(NSString *)cellIdentifier
     cellConfigureBlock:(TableViewCellConfigureBlock)cellConfigureBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
