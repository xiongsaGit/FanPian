//
//  SMTBarView.m
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTBarView.h"
#import "SMTImageLabelView.h"

@interface SMTBarView()
@property (nonatomic, strong) SMTImageLabelView *goodImageLabelView;
@property (nonatomic, strong) SMTImageLabelView *replyImageLabelView;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, copy) BarViewClickItemBlock clickBlock;

@end

@implementation SMTBarView


- (id)initWithFrame:(CGRect)frame clickBlock:(BarViewClickItemBlock)clickBlock {

    if (self = [super initWithFrame:frame]) {
        
        self.clickBlock = clickBlock;
        self.goodImageLabelView = [self factoryForImageLabelViewWithTag:0];
        self.replyImageLabelView = [self factoryForImageLabelViewWithTag:1];
        
        __weak typeof(self)weakSelf = self;
        self.goodImageLabelView.clickBlock = ^(){
            [weakSelf clickItemWithTag:0];
        };
        self.replyImageLabelView.clickBlock = ^(){
            [weakSelf clickItemWithTag:1];
        };
        [self addSubview:self.goodImageLabelView];
        [self addSubview:self.replyImageLabelView];
        [self addSubview:self.moreButton];
    }
    return self;
}

- (void)configureEventAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked {
    if (itemTag == 0) {
        [self.goodImageLabelView configureWitState:isChecked];
    }
}

- (void)itemLabelTextColor:(UIColor *)textColor {
    
    [self.goodImageLabelView configureLabelTextColor:textColor];
    [self.replyImageLabelView configureLabelTextColor:textColor];

}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.goodImageLabelView.frame = CGRectMake(kEdge, 0, CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.frame));
    self.replyImageLabelView.frame = CGRectMake(CGRectGetMaxX(self.goodImageLabelView.frame)+2*kEdge, 0, CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.frame));

    if (_items.count>=2) {
        [self.goodImageLabelView configureImageName:_items[0][@"imageName"] labelTitle:_items[0][@"title"]];
        [self.replyImageLabelView configureImageName:_items[1][@"imageName"] labelTitle:_items[1][@"title"]];
    }
    
    
    UIImage *image = [UIImage imageNamed:@"more"];
    [self.moreButton setBackgroundImage:image forState:UIControlStateNormal];
    CGRect moreRect = self.moreButton.frame;
    moreRect.origin = CGPointMake(CGRectGetWidth(self.frame)-CGRectGetWidth(moreRect)-2*kEdge, (CGRectGetHeight(self.frame)-CGRectGetHeight(moreRect))/2);
    self.moreButton.frame = moreRect;
}


- (void)clickItemWithTag:(NSInteger)tag {
    if (self.clickBlock) {
        self.clickBlock(tag);
    }
}

- (void)moreButtonClicked:(UIButton *)btn {
    [self clickItemWithTag:btn.tag];
}

- (SMTImageLabelView *)factoryForImageLabelViewWithTag:(NSInteger)tag {
    SMTImageLabelView *imagelabl = [[SMTImageLabelView alloc] initWithFrame:CGRectZero type:ImageLabelTypeImageLeft];
    imagelabl.tag = tag;
    return imagelabl;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.tag = 3;
        UIImage *image = [UIImage imageNamed:@"more"];
        [_moreButton setBackgroundImage:image forState:UIControlStateNormal];
        _moreButton.size = image.size;
    }
    return _moreButton;
}

@end
