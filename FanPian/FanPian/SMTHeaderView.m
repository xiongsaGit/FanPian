//
//  SMTHeaderView.m
//  LabelOnImageView
//
//  Created by sa.xiong on 16/1/26.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTHeaderView.h"
#import "ShowLabelOnImageView.h"
#import "SMTSalonListModel.h"
#define WHITE_SPACE 10

@interface SMTHeaderView()
@property (nonatomic, strong) ShowLabelOnImageView *leftLabelOnImageView;
@property (nonatomic, strong) ShowLabelOnImageView *rightLabelOnImageView;
@property (nonatomic, copy) HeaderViewItemClickBlock itemClickBlock;

@end

@implementation SMTHeaderView


- (id)initWithItemClickBlock:(HeaderViewItemClickBlock)clickBlock {
    if (self = [super init]) {
        self.itemClickBlock = clickBlock;
        self.leftLabelOnImageView = [self factoryForLabelOnImageViewWithTag:0];
        self.rightLabelOnImageView = [self factoryForLabelOnImageViewWithTag:1];
        [self addSubview:self.leftLabelOnImageView];
        [self addSubview:self.rightLabelOnImageView];
        self.leftLabelOnImageView.backgroundColor = [UIColor redColor];
         self.rightLabelOnImageView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)loadDataArray:(NSArray *)data {

    if (data.count>=2) {
        SMTSalonListModel *leftListModel = data[0];
        SMTSalonListModel *rightListModel = data[1];

        [self.leftLabelOnImageView showImageWithImagePath:leftListModel.icon];
        [self.leftLabelOnImageView showTextWithIntro:leftListModel.name subject:@""];
        
        [self.rightLabelOnImageView showImageWithImagePath:rightListModel.icon];
        [self.rightLabelOnImageView showTextWithIntro:rightListModel.name subject:@""];
        
        
    }
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self configureFrame];
}

- (void)configureFrame {
    CGFloat itemWidth =  (CGRectGetWidth(self.frame)-3*WHITE_SPACE)/2;
    CGFloat itemHeight = CGRectGetHeight(self.frame)-2*WHITE_SPACE>itemWidth?itemWidth:CGRectGetHeight(self.frame)-2*WHITE_SPACE;
    self.leftLabelOnImageView.frame = CGRectMake(WHITE_SPACE, WHITE_SPACE,itemWidth, itemHeight);
    self.rightLabelOnImageView.frame = CGRectMake(CGRectGetMaxX(self.leftLabelOnImageView.frame)+WHITE_SPACE, CGRectGetMinX(self.leftLabelOnImageView.frame), itemWidth, itemHeight);
}


- (void)clickEventOn:(ShowLabelOnImageView *)item {
    if (self.itemClickBlock) {
        self.itemClickBlock(item.tag);
    }
}

- (ShowLabelOnImageView *)factoryForLabelOnImageViewWithTag:(NSInteger)tag {
    __weak typeof(self)weakSelf = self;

    ShowLabelOnImageView *labelOnImageView = [[ShowLabelOnImageView alloc] initWithClickBlock:^(ShowLabelOnImageView *item) {
        [weakSelf clickEventOn:item];

    }];
    labelOnImageView.tag = tag;
  
    return labelOnImageView;
}


@end
