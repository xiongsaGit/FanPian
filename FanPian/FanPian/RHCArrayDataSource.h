//
//  RHCArrayDataSource.h
//  Renrenlicai_ios_instalment
//
//  Created by sa.xiong on 15/12/29.
//  Copyright © 2015年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TableViewCellConfigureBlock)(id cell, id item);


@interface RHCArrayDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureBlock;

- (id)initWithItems:(NSMutableArray *)aItems
     cellIdentifier:(NSString *)aCellIdentifier
     configureBlock:(TableViewCellConfigureBlock)aConfigureBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end