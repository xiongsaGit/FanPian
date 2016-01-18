//
//  SMTNavTitleView.m
//  FanPian
//
//  Created by sa.xiong on 16/1/14.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTNavTitleView.h"

@interface SMTNavTitleView()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NavTitleItemClickBlcok itemClickBlock;
@property (nonatomic, assign) NSInteger lastSelectIndex;
@end
@implementation SMTNavTitleView

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items clickBlock:(NavTitleItemClickBlcok)itemClcikBlock {
    if (self = [super initWithFrame:frame]) {
        self.lastSelectIndex = -1;
        self.items = items;
        self.itemClickBlock = itemClcikBlock;
        [self setupItems:items];
    }
    return self;
}

- (void)selectItem:(NSInteger)index {
    UIButton *selectButton;
    for (UIButton *item in self.subviews) {
        [item setSelected:NO];
        if (item.tag == index) {
            selectButton = item;
        }
    }
    [selectButton setSelected:YES];
}

- (void)itemClick:(UIButton *)itemButton {
    
    [self selectItem:itemButton.tag];
    
    if (self.lastSelectIndex != itemButton.tag) {
        self.lastSelectIndex = itemButton.tag;
        if (self.itemClickBlock) {
            self.itemClickBlock(itemButton.tag);
        }
    }
}

- (void)setupItems:(NSArray *)items {
    for (NSInteger i = 0; i < items.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*(CGRectGetWidth(self.frame)/items.count), 0, (CGRectGetWidth(self.frame)/items.count), CGRectGetHeight(self.frame))];
        [btn setTitle:items[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
